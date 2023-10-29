variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "bucket_name" {
  type    = string
  default = ""
}

variable "enable_versioning" {
  type    = bool
  default = true
}
