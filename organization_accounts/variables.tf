variable "accounts" {
  type = map(any)
  default = {
    # first_account = {
    #   "name"  : "account-000000000000",
    #   "email" : ""
    # },
    second_account = {
      "name" : "account-111111111111",
      "email" : "email+stage@gmail.com"
    },
  }
}
