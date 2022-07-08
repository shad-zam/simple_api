resource "aws_inspector_resource_group" "app_svr" {
  tags = {
    Inspector   = "common"

  }
}

resource "aws_inspector_assessment_target" "app_svr" {
  name               = "assessment target app servers"
  resource_group_arn = aws_inspector_resource_group.app_svr.arn
}

resource "aws_inspector_assessment_template" "example" {
  name       = "app servers assesment template"
  target_arn = aws_inspector_assessment_target.app_svr.arn
  duration   = 3600

  rules_package_arns = ["arn:aws:inspector:eu-west-2:146838936955:rulespackage/0-kZGCqcE1"]
}