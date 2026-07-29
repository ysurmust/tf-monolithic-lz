resource "azrurerm_key_vault" "key_vault" {
  for_each            = var.key_vaults
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tenant_id           = each.value.tenant_id
  sku_name            = each.value.sku_name

  access_policy {
    tenant_id = each.value.access_policy.tenant_id
    object_id = each.value.access_policy.object_id

    key_permissions         = each.value.access_policy.key_permissions
    secret_permissions      = each.value.access_policy.secret_permissions
    certificate_permissions = each.value.access_policy.certificate_permissions
  }

  tags = each.value.tags
}