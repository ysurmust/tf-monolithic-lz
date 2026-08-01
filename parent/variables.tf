variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "virtual_networks" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  }))
}

variable "storage_accounts" {}


variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}


variable "network_interfaces" {
  type = any
}


variable "vms" {
  type = any
}

variable "bastions" {
  type = any
}

variable "public_ips" {
  type = any
}

variable "peerings" {
  type = any
}

variable "network_security_groups" {
  type = any
}

# variable "key_vaults" {
#   type = any
# }

variable "key_vaults_AP" {
  type = any
}


