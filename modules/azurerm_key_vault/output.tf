output "key_vault_ids" {
  value = { for kv in azurerm_key_vault.key_vault : kv.name => kv.id }
}   