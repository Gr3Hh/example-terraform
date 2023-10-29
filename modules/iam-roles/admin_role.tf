resource "aws_iam_role" "admin_role" {
  name = var.admin_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = { "AWS" : "arn:aws:iam::${data.aws_caller_identity.first.account_id}:root" }
    }]
  })
}

data "aws_iam_policy_document" "admin_policy" {
  statement {
    effect      = "Allow"
    not_actions = ["iam:*"]
    resources   = ["*"]
  }
}

resource "aws_iam_policy" "admin_policy" {
  name        = var.admin_policy_name
  description = "A policy for access to all services except IAM"
  policy      = data.aws_iam_policy_document.admin_policy.json
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.admin_role.name
  policy_arn = aws_iam_policy.admin_policy.arn
}
