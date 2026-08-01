# output "key_vault_ids" {
#   value = { for kv in azurerm_key_vault.key_vault_AP : kv.name => kv.id }
# }