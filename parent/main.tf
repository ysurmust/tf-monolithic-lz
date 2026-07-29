module "resource_group" {
  source          = "../modules/azurerm_resource_group" # calling child module
  resource_groups = var.resource_groups                 # sending input variable to child module

}


module "virtual_network" {
  depends_on       = [module.resource_group]              #depend upon resource group module to create virtual network
  source           = "../modules/azurerm_virtual_network" # calling child module
  virtual_networks = var.virtual_networks                 # sending variable form TVFARS to child moqdule
}

module "subnet" {
  depends_on = [module.virtual_network, module.resource_group]
  source     = "../modules/azurerm_subnet"
  subnets    = var.subnets
}

# module "storage_account" {
#   depends_on       = [module.resource_group]
#   source           = "../modules/azurerm_storage_account"
#   storage_accounts = var.storage_accounts
# }


# hiding it
# module "network_interface" {
#   depends_on = [module.subnet, module.resource_group]
#   source     = "../modules/azurerm_network_interface"
#   nics       = var.network_interfaces # sending variable form TVFARS to child moqdule
#   #subnet_ids = module.subnet.subnet_ids # this output module also need to be created in subnet module to get the subnet id and pass it to network interface module
# }


# module "linux_virtual_machine" {
#   depends_on             = [module.subnet, module.resource_group]
#   source                 = "../modules/azurerm_linux_virtual_machine"
#   linux_virtual_machines = var.linux_virtual_machines
#   nics                   = var.network_interfaces

# }



# module "public_ip" {
#   depends_on = [module.resource_group]
#   source     = "../modules/azurerm_public_ip"
#   public_ips = var.public_ips
# }

# module "bastion" {
#   depends_on    = [module.subnet, module.resource_group, module.public_ip]
#   source        = "../modules/azurerm_bastion"
#   bastions      = var.bastions
#   subnet_ids    = module.subnet.subnet_ids       # this output module also need to be created in subnet module to get the subnet id and pass it to bastion module
#   public_ip_ids = module.public_ip.public_ip_ids # this output module also need to be created in public ip module to get the public ip id and pass it to bastion module
# }

# module "peering" {
#   depends_on = [module.virtual_network, module.resource_group]
#   source     = "../modules/azurerm_virtual_network_peering"
#   peerings   = var.peerings
#   vnet_ids   = module.virtual_network.vnet_ids # this output module also need to be created in virtual network module to get the vnet id and pass it to peering module
# }

# module "network_security_group" {
#   depends_on              = [module.resource_group]
#   source                  = "../modules/azurerm_network_security_group"
#   network_security_groups = var.network_security_groups
# }

module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../modules/azurerm_key_vault"
  key_vaults = var.key_vaults
}

module "key_vault_with_access_policies" {
  depends_on                      = [module.resource_group]
  source                          = "../modules/azurerm_key_vault_with_AccessPolicy"
  key_vaults_with_access_policies = var.key_vaults_with_access_policies
}

module "key_vault_secret" {
  depends_on        = [module.key_vault, module.key_vault_with_access_policies]
  source            = "../modules/azurerm_key_vault_secret"
  key_vault_id      = module.key_vault_with_access_policies.key_vault_ids["surmustKeyVaultWithAP"] # Assuming you want to use the first Key Vault created in the key_vault module
  key_vault_secrets = var.key_vault_secrets
}