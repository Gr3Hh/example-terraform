variable "accounts" {
  type    = map(any)
  default = {}
}

variable "close_on_deletion" {
  type    = bool
  default = true
}