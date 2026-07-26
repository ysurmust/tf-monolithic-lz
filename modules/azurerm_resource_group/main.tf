resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
}

variable "resource_groups" {
  description = "A map of resource groups to create."
  type = map(object({
    name     = string
    location = string
  }))
}
