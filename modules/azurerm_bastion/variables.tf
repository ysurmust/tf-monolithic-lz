variable "subnet_ids" {
  type = map(string)
}

variable "public_ip_ids" {
  type = map(string)
}


variable "bastions" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = string
    ip_configuration = object({
      name          = string
      subnet_key    = string
      public_ip_key = string
    })
  }))
}
