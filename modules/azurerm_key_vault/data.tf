#Get current user/service principal. This is needed for access policies
data "azurerm_client_config" "current" {}