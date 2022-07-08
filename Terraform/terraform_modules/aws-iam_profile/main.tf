data "aws_iam_policy" "policies" {
    for_each = toset(var.policies)
    name = each.value
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "attach" {
    for_each = data.aws_iam_policy.policies
  name       = "${var.name}-role-attachment"
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn = each.value.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name}-ec2_profile"
  role = aws_iam_role.ec2_role.name
}