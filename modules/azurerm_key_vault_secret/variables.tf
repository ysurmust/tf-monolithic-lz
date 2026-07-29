variable "key_vault_id" {
  type = string
}

variable "key_vault_secrets" {
  type = map(object({
    name  = string
    value = string
  }))
}
