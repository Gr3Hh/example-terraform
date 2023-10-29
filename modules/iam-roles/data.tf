data "aws_caller_identity" "first" {}

data "aws_caller_identity" "second" {
  provider = aws.second
}