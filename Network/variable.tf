variable "vnet_name" {
    type = string
    description = "Nazwa sieci"
}
variable "vnet_address_space" {
  type = list(string)
  description = "Adres sieci wirtualnej"
}
variable "tags" {
  type = map(any)
  description = "tagi"
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}