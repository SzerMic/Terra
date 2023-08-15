variable "global_tags" {
  description = "Globalne tagi"
  type        = map(any)
  default     = {}
}
variable "interfacetag" {
  type    = map(any)
  default = {}
}
variable "vmtags" {
  type    = map(any)
  default = {}
}
variable "resource_group_name" {
  type    = string
  default = "RG_FinApp_PoC"
}
variable "resource_group_location" {
  type    = string
  default = "West Europe"
}
variable "virtual_network_name" {
  type        = string
  default     = "vnet_FinApp_PoC"
  description = "Nazwa sieci"
}
variable "vnet_address_space" {
  type        = list(any)
  description = "Adres sieci"
  default     = ["10.255.254.0/23"]
}
variable "subnetname" {
  type    = string
  default = "Subnetname123"
}
variable "subnetaddress" {
  type    = list(any)
  default = ["10.255.254.0/28"]
}
variable "subnetname1" {
  type    = string
  default = "Subnetname1234"
}
variable "subnetaddress1" {
  type    = list(any)
  default = ["10.255.254.32/27"]
}
variable "nsg" {
  type    = string
  default = "randomenameofnsg1432"
}
variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}
variable "dnsname" {
  type    = string
  default = "private.azurewebsites.net"
}
variable "dnsname2" {
  type    = string
  default = "private.vm.windows.net"
}
variable "linkdnsname" {
  type = string
}
variable "linkdnsname2" {
  type = string
}
variable "localadmin" {
  type        = string
  description = "Admin username"
}
variable "adminpass" {
  type        = string
  sensitive   = true #Niewidoczne hasło
  description = "Password to admin"
}
variable "pc_net_interface" {
  type        = string
  description = "Name interface"
}
variable "appname" {
  type    = string
  default = "appnamegg45o9"
}
variable "endname" {
  type    = string
  default = "priendpointnameconectorornot2"
}
variable "is_manual_connection" {
  type    = bool
  default = "false"
}