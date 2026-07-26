# output "nic_ids" {
#   value = {
#     for k, nic in azurerm_network_interface.nics :
#     k => nic.id
#   }
# }


# output "subnet_ids" {
#   value = {
#     for k, subnet in azurerm_subnet.subnet :
#     k => subnet.id
#   }
# }


# output "vm_ids" {
#   value = {
#     for k, v in azurerm_virtual_machine.virtual_machines_terraform :
#     k => v.id
#   }
# }


# output "vnet_ids" {
#   value = {
#     for k, v in azurerm_virtual_network.vnet :
#     k => v.id
#   }
# }