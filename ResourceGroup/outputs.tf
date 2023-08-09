output "rs_id" {
    description = "ID utworzonego zasobu"
    value = azurerm_resource_group.rs
}
output "resource_group_name_out" {
  description = "Wyjscie nazwy rs"
  value = azurerm_resource_group.rs.name
}
output "resource_group_location_out" {
    description = "wyjscie lokalizacji rs"
    value = azurerm_resource_group.rs.location
}