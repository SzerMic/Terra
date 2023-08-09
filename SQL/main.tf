# DB Acc
resource "azurerm_storage_account" "DBACC" {
  name                     = var.namea
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}
# Server
resource "azurerm_mssql_server" "Server" {
  name                         = var.names
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.localadmin
  administrator_login_password = var.adminpass

}
# DB
resource "azurerm_mssql_database" "DB" {
  name      = var.named
  server_id = azurerm_mssql_server.Server.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  sku_name  = "Basic"
  zone_redundant = true
  read_scale     = true
  max_size_gb    = 4
  license_type   = "LicenseIncluded"

}