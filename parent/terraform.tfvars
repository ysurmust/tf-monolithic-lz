resource_groups = {
  rg1 = {
    name     = "rg1"
    location = "Australia East"
  }
  rg2 = {
    name     = "rg2"
    location = "Australia East"
  }
}

virtual_networks = {
  vnet1 = {
    name                = "vnet1"
    location            = "Australia East"
    resource_group_name = "rg1"
    address_space       = ["10.0.0.0/16"]
  }
  vnet2 = {
    name                = "vnet2"
    location            = "Australia East"
    resource_group_name = "rg1"
    address_space       = ["10.1.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "frontend"
    resource_group_name  = "rg1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "backend"
    resource_group_name  = "rg1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg1"
    virtual_network_name = "vnet1"
    address_prefixes     = ["10.0.3.0/26"]
  }
}

network_interfaces = {
  nic1 = {
    name                          = "nic1_frontend"
    location                      = "Australia East"
    resource_group_name           = "rg1"
    ip_name                       = "nic1-ipconfig"
    subnet_name                   = "frontend"
    virtual_network_name          = "vnet1"
    private_ip_address_allocation = "Dynamic"
  }
  nic2 = {
    name                          = "nic2_backend"
    location                      = "Australia East"
    resource_group_name           = "rg1"
    ip_name                       = "nic2-ipconfig"
    subnet_name                   = "backend"
    virtual_network_name          = "vnet1"
    private_ip_address_allocation = "Dynamic"
  }
}



public_ips = {
  bastion_pip = {
    name                = "bastion-public-ip"
    location            = "Australia East"
    resource_group_name = "rg1"
    allocation_method   = "Static"
    sku                 = "Standard"
    # tags = {
    #   environment = "dev"
    #   project     = "terraform-modules"
    #}
  }
  # public_ip2 = {
  #   name                = "public-ip2"
  #   location            = "Australia East"
  #   resource_group_name = "rg1"
  #   allocation_method   = "Dynamic"
  #   sku                 = "Basic"
  #   tags                = {
  #     environment = "prod"
  #     project     = "terraform-modules"
  #   }
  # }
}



linux_virtual_machines = {

  vm1 = {
    name                            = "linuxvm1"
    location                        = "Australia East"
    resource_group_name             = "rg1"
    size                            = "Standard_B2ats_v2"
    admin_username                  = "azureuser"
    admin_password                  = "Password12345!"
    disable_password_authentication = false

    network_interface_keys = ["nic1"]

    os_disk_caching              = "ReadWrite"
    os_disk_storage_account_type = "Standard_LRS"

    image_publisher = "Canonical"
    image_offer     = "0001-com-ubuntu-server-jammy"
    image_sku       = "22_04-lts-gen2"
    image_version   = "latest"
  }

  vm2 = {
    name                            = "linuxvm2"
    location                        = "Australia East"
    resource_group_name             = "rg1"
    size                            = "Standard_B2ats_v2"
    admin_username                  = "azureuser"
    admin_password                  = "Password12345!"
    disable_password_authentication = false

    network_interface_keys = ["nic2"]

    os_disk_caching              = "ReadWrite"
    os_disk_storage_account_type = "Standard_LRS"

    image_publisher = "Canonical"
    image_offer     = "0001-com-ubuntu-server-jammy"
    image_sku       = "22_04-lts-gen2"
    image_version   = "latest"
  }
}



bastions = {
  bastion1 = {
    name                = "AzureBastion"
    location            = "Australia East"
    resource_group_name = "rg1"
    sku                 = "Standard"

    ip_configuration = {
      name          = "bastion-ipconfig"
      subnet_key    = "subnet3"     # This should reference the subnet ID from the output of the subnet module
      public_ip_key = "bastion_pip" # You can set this to a public IP ID if you have one, or leave it as null for automatic assignment
    }
  }
}

peerings = {
  peering1 = {
    name                         = "vnet1-to-vnet2"
    resource_group_name          = "rg1"
    virtual_network_name         = "vnet1"
    remote_virtual_network_key   = "vnet2" # This should reference the key of the remote virtual network in the virtual_networks map
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
  peering2 = {
    name                         = "vnet2-to-vnet1"
    resource_group_name          = "rg1"
    virtual_network_name         = "vnet2"
    remote_virtual_network_key   = "vnet1" # This should reference the key of the remote virtual network in the virtual_networks map
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}


network_security_groups = {
  ssh = {
    name                = "linux-nsg"
    location            = "Australia East"
    resource_group_name = "rg1"

    security_rule = {
      name                       = "AllowSSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  rdp = {
    name                = "windows-nsg"
    location            = "Australia East"
    resource_group_name = "rg1"

    security_rule = {
      name                       = "AllowRDP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  http = {
    name                = "http-nsg"
    location            = "Australia East"
    resource_group_name = "rg1"

    security_rule = {
      name                       = "AllowHTTP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}