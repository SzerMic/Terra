terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.62.1"
    }
  }
}

provider "azurerm" {
  features {
  }
}
# disc_enc
data "azurerm_client_config" "pc-client-config" {}

# Tworzenie resources group
module "ResourceGroup" {
  source      = "./ResourceGroup"
  rs_name     = var.resource_group_name
  rs_location = var.resource_group_location
  tags        = var.global_tags
}
# Tworzenie sieci wirtualnej
module "Network" {
  source              = "./Network"
  vnet_name           = var.virtual_network_name
  vnet_address_space  = var.vnet_address_space
  location            = module.ResourceGroup.resource_group_location_out
  resource_group_name = module.ResourceGroup.resource_group_name_out
  tags                = var.global_tags
}
# Tworzenie podsieci1
resource "azurerm_subnet" "subnet" {
  # for_each             = var.subnets
  resource_group_name  = module.ResourceGroup.resource_group_name_out
  virtual_network_name = module.Network.virtual_network_name_out
  name                 = var.subnetname
  address_prefixes     = var.subnetaddress
}
# Tworzenie podsieci2
resource "azurerm_subnet" "subnet2" {
  # for_each             = var.subnets
  resource_group_name  = module.ResourceGroup.resource_group_name_out
  virtual_network_name = module.Network.virtual_network_name_out
  name                 = var.subnetname1
  address_prefixes     = var.subnetaddress1
}
#NSG
resource "azurerm_network_security_group" "network_security_group" {
  name                = var.nsg
  location            = module.ResourceGroup.resource_group_location_out
  resource_group_name = module.ResourceGroup.resource_group_name_out

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }

  tags = var.global_tags
}
#DNS 1
module "dns123" {
  source              = "./Network/DNS"
  name                = var.dnsname
  resource_group_name = module.ResourceGroup.resource_group_name_out
}
# DNS2
module "dnsss" {
  source              = "./Network/DNS"
  name                = var.dnsname2
  resource_group_name = module.ResourceGroup.resource_group_name_out
}
# # Podlinkowanie DNS-website
# resource "azurerm_private_dns_zone_virtual_network_link" "pc_podliknowany_dns1" {
#   name                  = var.linkdnsname
#   resource_group_name   = module.ResourceGroup.resource_group_name_out
#   private_dns_zone_name = module.dns123.dnsname
#   virtual_network_id    = module.Network.virtual_network_id
# }
# # Podlinkowanie DNS-VM
# resource "azurerm_private_dns_zone_virtual_network_link" "pc_podliknowany_dns2" {
#   name                  = var.linkdnsname2
#   resource_group_name   = module.ResourceGroup.resource_group_name_out
#   private_dns_zone_name = module.dnsss.dnsname2
#   virtual_network_id    = module.Network.virtual_network_id
# }
# App service plan
resource "azurerm_service_plan" "pc_asp-FinApp-FE-PoC" {
  name                = "asp_FinApp-FE-PoC"
  location            = module.ResourceGroup.resource_group_location_out
  resource_group_name = module.ResourceGroup.resource_group_name_out
  os_type             = "Windows"
  sku_name            = "P1v2"

  tags = var.global_tags
}
# App Serivce
resource "azurerm_windows_web_app" "pc_app_service" {
  name                = var.appname
  location            = module.ResourceGroup.resource_group_location_out
  resource_group_name = module.ResourceGroup.resource_group_name_out
  service_plan_id     = azurerm_service_plan.pc_asp-FinApp-FE-PoC.id

  site_config {
  }
  tags = var.global_tags
}
resource "azurerm_network_interface" "windows_nic" {
  name                = "firstconfigintip2"
  location            = module.ResourceGroup.resource_group_location_out
  resource_group_name = module.ResourceGroup.resource_group_name_out

  ip_configuration {
    name                             = "firstconfigintip"
    private_ip_address_allocation    = "Dynamic"
    subnet_id                        = azurerm_subnet.subnet2.id
  }
  tags = var.interfacetag
}
#Maszyna virtualna
module "VM-win" {
  source = "./VirutalMachines"

  name                = "vm-win-atg-moj-pdd"
  resource_group_name = module.ResourceGroup.resource_group_name_out
  location            = module.ResourceGroup.resource_group_location_out
  size_VM             = "Standard_B1s"
  localadmin          = var.localadmin
  adminpass           = var.adminpass
  # subnetid            = azurerm_subnet.subnet2.id
  network_interface_ids = [
    azurerm_network_interface.windows_nic.id,
    ]
  tags                = var.global_tags
}
module "StorageAccount" {
  source = "./StorageAccount"
  name = "FirstSorage"
  resource_group_name = module.ResourceGroup.resource_group_name_out
  location = module.ResourceGroup.resource_group_location_out
  account_tier = "Standard"
  account_replication_type = "GRS"
}
module "SQL_DB" {
  source = "./SQL"
  
  namea = "Randomstringnametr345"
  named = "Randomstringamsr26tr"
  names = "Randomstgdskn65odlsxc"
  localadmin = var.localadmin
  adminpass = var.adminpass
  location = module.ResourceGroup.resource_group_location_out
  resource_group_name = module.ResourceGroup.resource_group_name_out
}