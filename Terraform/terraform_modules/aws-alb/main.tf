
resource "aws_lb" "default" {
  count              = var.create_lb ? 1 : 0
  name               = var.name
  tags               = var.tags
  internal           = var.internal
  load_balancer_type = "application"

  security_groups = var.security_group_ids

  subnets                          = var.subnet_ids
  enable_cross_zone_load_balancing = var.cross_zone_load_balancing_enabled
  enable_http2                     = var.http2_enabled
  idle_timeout                     = var.idle_timeout
  ip_address_type                  = var.ip_address_type
  enable_deletion_protection       = var.deletion_protection_enabled
  drop_invalid_header_fields       = var.drop_invalid_header_fields

  access_logs {
    bucket  = var.access_logs_s3_bucket_id
    prefix  = var.access_logs_prefix
    enabled = var.access_logs_enabled
  }
}

resource "aws_lb_target_group" "default" {
  count                = var.create_lb ? 1 : 0
  name                 = var.name
  port                 = var.target_group_port
  protocol             = var.target_group_protocol
  vpc_id               = var.vpc_id
  target_type          = var.target_group_target_type
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  health_check {
    protocol            = var.target_group_protocol
    path                = var.health_check_path
    port                = var.health_check_port
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
  }
  tags = var.tags
}

resource "aws_lb_target_group_attachment" "test" {
  count = var.attach_target ? var.instance_count : 0
  target_group_arn = aws_lb_target_group.default.*.arn[0]
  target_id        = var.target_instances[count.index]
  port             = var.https_enabled ? var.https_port : var.http_port
}

resource "aws_lb_listener" "http" {
  count             = var.create_lb ? 1 : 0
  load_balancer_arn = aws_lb.default.*.arn[0]
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.default.*.arn[0]
    type             = "forward"
  }
}


resource "aws_lb_listener" "https" {
  count             = var.create_lb && var.https_enabled ? 1 : 0
  load_balancer_arn = join("", aws_lb.default.*.arn)

  port            = var.https_port
  protocol        = "HTTPS"
  ssl_policy      = var.https_ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.default.*.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_certificate" "https_sni" {
  count           = var.create_lb && var.https_enabled && var.additional_certs != [] ? length(var.additional_certs) : 0
  listener_arn    = join("", aws_lb_listener.https.*.arn)
  certificate_arn = var.additional_certs[count.index]
}
