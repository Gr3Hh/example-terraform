output "gui_account_passwords" {
  value = module.iam_accounts.gui_account_passwords
}

output "cli_account_passwords" {
  value = module.iam_accounts.cli_user_keys
}
