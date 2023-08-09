variable "name" {
    type = string
    description = "Nazwa VM"
}
variable "tags"{
    type = map(any)
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "size_VM" {
  type = string
}
variable "localadmin" {
  type = string
  default = "admin"
  sensitive = true
}
variable "adminpass" {
  type = string
  default = "localadminPASS145@"
  sensitive = true
}
variable "network_interface_ids" {
  type = list(string)
}
