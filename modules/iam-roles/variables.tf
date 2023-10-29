variable "admin_role_name" {
  type    = string
  default = "roleA"
}

variable "admin_policy_name" {
  type    = string
  default = "AdminPolicy"
}


#### Crossaccount roles ####
variable "source_role_name" {
  type    = string
  default = "roleB"
}

variable "source_role_policy_name" {
  type    = string
  default = "SourceAssumeRole"
}

variable "target_role_name" {
  type    = string
  default = "roleC"
}

variable "target_role_policy_name" {
  type    = string
  default = "S3Access"
}