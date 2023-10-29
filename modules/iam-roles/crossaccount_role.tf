###################
### Source Role ###
###################

resource "aws_iam_role" "source_role" {
  name = var.source_role_name
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

data "aws_iam_policy_document" "source_role_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.second.account_id}:role/${aws_iam_role.target_role.name}"]
  }
}

resource "aws_iam_policy" "source_role_policy" {
  name        = var.source_role_policy_name
  description = "This policy allow AssumeRole to specific role"
  policy      = data.aws_iam_policy_document.source_role_policy.json
}

resource "aws_iam_role_policy_attachment" "source_policy_attachment" {
  role       = aws_iam_role.source_role.name
  policy_arn = aws_iam_policy.source_role_policy.arn
}

###################
### Target Role ###
###################

resource "aws_iam_role" "target_role" {
  provider = aws.second

  name = var.target_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",

        Principal = { "AWS" : "arn:aws:iam::${data.aws_caller_identity.first.account_id}:role/${aws_iam_role.source_role.name}" },
    }]
  })
}

data "aws_iam_policy_document" "target_role_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::aws-test-bucket"]
  }
}

resource "aws_iam_policy" "target_role_policy" {
  provider = aws.second

  name        = var.target_role_policy_name
  description = "A policy for access to aws-test-bucket bucket"
  policy      = data.aws_iam_policy_document.target_role_policy.json
}

resource "aws_iam_role_policy_attachment" "target_policy_attachment" {
  provider = aws.second

  role       = aws_iam_role.target_role.name
  policy_arn = aws_iam_policy.target_role_policy.arn
}
