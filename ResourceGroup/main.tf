resource "azurerm_resource_group" "rs" {
  name     = var.rs_name
  location = var.rs_location
  tags = var.tags
}