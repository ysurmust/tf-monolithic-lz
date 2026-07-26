variable "key_vaults" {
  description = "A list of key vaults to create"
  type        = list(map(any))
}