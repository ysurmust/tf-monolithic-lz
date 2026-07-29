resource "azurerm_network_interface" "nics" {
  for_each = var.nics

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_name
    subnet_id                     = data.azurerm_subnet.subnets[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}



resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {

  for_each = var.linux_virtual_machines

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  size = each.value.size

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  disable_password_authentication = each.value.disable_password_authentication

  network_interface_ids = [
    for nic_key in each.value.network_interface_keys :
    azurerm_network_interface.nics[nic_key].id
  ]



  computer_name = try(each.value.computer_name, null)

  os_disk {

    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_account_type

  }

  source_image_reference {

    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version

  }

}

