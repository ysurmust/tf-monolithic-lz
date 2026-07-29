resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each     = var.key_vault_secrets
  name         = each.value.name
  value        = each.value.value
  key_vault_id = var.key_vault_id
}