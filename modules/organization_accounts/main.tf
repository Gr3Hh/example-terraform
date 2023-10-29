resource "aws_organizations_account" "account" {
  for_each = var.accounts

  name              = each.value.name
  email             = each.value.email
  close_on_deletion = var.close_on_deletion
}
