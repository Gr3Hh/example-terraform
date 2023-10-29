#### Share ####
variable "force_destroy" {
  type    = bool
  default = true
}

#### GUI users ####
variable "gui_users_account" {
  type    = set(string)
  default = []
}

variable "password_reset_required" {
  type    = bool
  default = true
}

variable "password_length" {
  type    = number
  default = 16
}

variable "gui_group_name" {
  type    = string
  default = "group2"
}

#### CLI users ####
variable "cli_user_accounts" {
  type    = set(string)
  default = []
}

variable "cli_group_name" {
  type    = string
  default = "group1"
}