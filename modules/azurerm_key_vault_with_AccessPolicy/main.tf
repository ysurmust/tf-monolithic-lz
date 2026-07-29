#This is example of how to use access policies if you want to use them instead of RBAC. You can uncomment the below block and provide the necessary permissions in the terraform.tfvars file.
resource "azurerm_key_vault" "key_vault_with_access_policies" {
  for_each                   = var.key_vaults_with_access_policies
  name                       = each.value.name
  location                   = each.value.location
  resource_group_name        = each.value.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = each.value.soft_delete_retention_days
  purge_protection_enabled   = each.value.purge_protection_enabled
  sku_name                   = each.value.sku_name

  # access policy clause to define permissions for the Key Vault
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions         = each.value.key_permissions
    secret_permissions      = each.value.secret_permissions
    certificate_permissions = each.value.certificate_permissions
  }

  #tags = each.value.tags
}

