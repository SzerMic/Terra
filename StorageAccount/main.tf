terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_password" "random" {
    length = 6
    special = false
    upper = false
}
resource "azurerm_storage_account" "str" {
  name                     = "${random_password.random.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}