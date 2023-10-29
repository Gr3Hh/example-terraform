variable "gui_users_account" {
  type = set(string)
  default = [
    "Denys Platon",
    "Ivan Petrenko",
  ]
}

variable "cli_user_accounts" {
  type = set(string)
  default = [
    "engine",
    "ci",
  ]
}
