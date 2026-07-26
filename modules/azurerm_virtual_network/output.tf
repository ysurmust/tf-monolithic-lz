output "vnet_ids" {
  value = {
    for vnet_key, vnet in azurerm_virtual_network.vnets :
    vnet_key => vnet.id
  }
}