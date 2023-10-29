###################################
### Users with cli access only ####
###################################

resource "aws_iam_user" "cli_user" {
  for_each = var.cli_user_accounts

  force_destroy = var.force_destroy

  name = each.value

  tags = {
    managed_by = "terraform"
  }
}


resource "aws_iam_access_key" "cli_user_key" {
  depends_on = [aws_iam_user.cli_user]
  for_each   = var.cli_user_accounts

  user = each.value
}


resource "aws_iam_group" "cli_users_group" {
  name = var.cli_group_name
}

resource "aws_iam_user_group_membership" "cli_users_member" {
  for_each = var.cli_user_accounts

  user = aws_iam_user.cli_user[each.key].name

  groups = [
    aws_iam_group.cli_users_group.name,
  ]
}


resource "aws_iam_group_policy_attachment" "cli_user_policy_attach" {
  for_each = toset([
    "arn:aws:iam::aws:policy/PowerUserAccess",
  ])

  group      = aws_iam_group.cli_users_group.name
  policy_arn = each.value
}


output "cli_user_keys" {
  value = {
    for data in aws_iam_access_key.cli_user_key :
    data.user => { "access_key" = data.id, "secret_key" = nonsensitive(data.secret) }
  }
}
