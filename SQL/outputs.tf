output "DBACC" {
  value = azurerm_storage_account.DBACC.id
}
output "SERVERID" {
  value = azurerm_mssql_server.Server.id
}
output "DBid" {
  value = azurerm_mssql_database.DB.id
}