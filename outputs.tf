output "RSName" {
  value       = module.ResourceGroup.resource_group_name_out
  description = "wyjsice RSName"
}
output "Network_name" {
  value       = module.Network.virtual_network_name_out
  description = "wyjsice NetworkName"
}
output "dns2name_out" {
  value = module.dns2.dnsname_out
}
output "dns1name_out" {
  value = module.dns2.dnsname_out
}
output "nsg_id" {
  value = azurerm_network_security_group.network_security_group.id
}
output "vm_id" {
  value = module.VM-win.vm_id_out
}
output "StgActName" {
  value     = module.StorageAccount.stg_act_name_out
  sensitive = true
}