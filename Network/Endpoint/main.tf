resource "azurerm_private_endpoint" "privend" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id = var.subnet_id

  private_service_connection {
    name                           = var.name
    is_manual_connection           = var.is_manual_connection
    private_connection_resource_id = var.private_connection_resource_id
  }
}