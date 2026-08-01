data "azurerm_subnet" "subnets" {
  for_each = var.vms

  name                 = each.value.nic_subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

# datablock to get vms variable to get informaiton
data "azurerm_key_vault" "kv" {
  for_each            = var.vms
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "admin_username" {
  for_each     = var.vms
  name         = each.value.secret_user_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_key_vault_secret" "admin_password" {
  for_each     = var.vms
  name         = each.value.secret_password_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}


