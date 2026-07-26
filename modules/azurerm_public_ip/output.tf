output "public_ip_ids" {
  value = {
    for k, public_ip in azurerm_public_ip.public_ips :
    k => public_ip.id
  }
}