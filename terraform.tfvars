global_tags = {
  project     = "FinApp"
  environment = "PoC"
}
interfacetag = {
  environment2 = "PoC2"
}
vmtags = {
  project2     = "FinApp2"
  environment2 = "PoC2"
}
virtual_network_name = "vnet_FinApp_PoC"

nsg_rules = [
  {
    name                       = "In-PE"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.255.254.64/26"
    destination_address_prefix = "10.255.254.0/28"
  },
  {
    name                       = "In-DennyAll"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Out-Backend"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.255.254.0/28"
    destination_address_prefix = "10.255.254.32/27"
  },
  {
    name                       = "Out-DennyAll"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]
nsg_rules_back = [
  {
    name                       = "In-Frontend"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.255.254.0/28"
    destination_address_prefix = "10.255.254.32/27"
  },
  {
    name                       = "In-DennyAll"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Out-PE"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.255.254.32/27"
    destination_address_prefix = "10.255.254.64/26"
  },
  {
    name                       = "Out-DennyAll"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

linkdnsname  = "linkowany-dns1"
linkdnsname2 = "linkowany-dns2"

vm_localadmin = "LoginAdmin"

vm_adminpass = "Admi25$n"

pc_net_interface = "net_interface"