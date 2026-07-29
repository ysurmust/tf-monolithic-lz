# data "azurerm_key_vault_secret" "key_vault_secret" {

#   for_each = var.key_vault_secrets

#   name = each.value.name

#   key_vault_id = module.key_vault_with_access_policies.key_vault_ids[each.value.key_vault_name]
# }