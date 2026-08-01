resource "azurerm_network_interface" "nics" {
  for_each = var.vms

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_name
    subnet_id                     = data.azurerm_subnet.subnets[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}



resource "azurerm_linux_virtual_machine" "vms" {

  for_each = var.vms

  name                = each.value.vms_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  size = each.value.vm_size

  # admin_username = each.value.admin_username
  # admin_password = each.value.admin_password

  # getting user name and password from databclok
  admin_username = data.azurerm_key_vault_secret.admin_username[each.key].value
  admin_password = data.azurerm_key_vault_secret.admin_password[each.key].value

  disable_password_authentication = each.value.disable_password_authentication

  network_interface_ids = [azurerm_network_interface.nics[each.key].id]


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

