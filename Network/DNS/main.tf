resource "azurerm_private_dns_zone" "dns" {
  name                = var.name
  resource_group_name = var.resource_group_name
}
resource "azurerm_private_dns_zone_virtual_network_link" "pod_dns" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = var.virtual_network_id
}
