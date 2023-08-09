# resource "azurerm_network_interface" "netinterface" {
#   name                = "firstconfigintip2"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = var.subnetid
#     private_ip_address_allocation = "Dynamic"
#   }
# }
resource "azurerm_windows_virtual_machine" "pc_vm" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size_VM
  admin_username      = var.localadmin
  admin_password      = var.adminpass
  network_interface_ids = var.network_interface_ids
  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 128
  }
  source_image_reference {
    publisher = "WindowsServer"
    offer     = "MicrosoftWindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}