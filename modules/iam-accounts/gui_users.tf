###################################
### Users with gui access only ####
###################################

resource "aws_iam_user" "gui_user" {
  for_each = var.gui_users_account

  force_destroy = var.force_destroy

  name = replace(each.key, "/\\s+/", "_")

  tags = {
    managed_by = "terraform"
  }
}

resource "aws_iam_user_login_profile" "gui_user" {
  depends_on = [aws_iam_user.gui_user]
  for_each   = var.gui_users_account

  user                    = aws_iam_user.gui_user[each.key].name
  password_reset_required = var.password_reset_required
  password_length         = var.password_length

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

output "gui_account_passwords" {
  value = {
    for user in aws_iam_user_login_profile.gui_user :
    user.user => { "initial password" = user.password }
  }
}

resource "aws_iam_group" "gui_users_group" {
  name = var.gui_group_name
}

resource "aws_iam_user_group_membership" "gui_users_member" {
  for_each = var.gui_users_account

  user = aws_iam_user.gui_user[each.key].name

  groups = [
    aws_iam_group.gui_users_group.name,
  ]
}

resource "aws_iam_group_policy_attachment" "gui_user_policy_attach" {
  for_each = toset([
    "arn:aws:iam::aws:policy/ReadOnlyAccess",
    "arn:aws:iam::aws:policy/IAMUserChangePassword"
  ])

  group      = aws_iam_group.gui_users_group.name
  policy_arn = each.value
}
