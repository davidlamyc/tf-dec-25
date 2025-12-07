resource "azurerm_resource_group" "nonprod_rg" {
  name     = local.resource_group_name
  location = local.resource_location
}

resource "azurerm_virtual_network" "nonprod_network" {
  name                = "app-network"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.nonprod_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet01" {
  name                 = "subnet01"
  resource_group_name  = azurerm_resource_group.nonprod_rg.name
  virtual_network_name = azurerm_virtual_network.nonprod_network.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Get the vendor's Resource Group
data "azurerm_resource_group" "nonprod_rg" {
  name = "nonprod-rg"  # The actual deployed RG name
}

output nonprod_rg_id {
    value=data.azurerm_resource_group.nonprod_rg.id
}

data "azurerm_virtual_network" "nonprod_network" {
  name                = "app-network"
  resource_group_name = data.azurerm_resource_group.nonprod_rg.name
}

output nonprod_network_name {
    value=data.azurerm_virtual_network.nonprod_network.name
}

# Get the vendor's Subnet
data "azurerm_subnet" "subnet01" {
  name                 = "subnet01"
  virtual_network_name = data.azurerm_virtual_network.nonprod_network.name
  resource_group_name  = data.azurerm_resource_group.nonprod_rg.name
}

output subnet_id {
    value=data.azurerm_subnet.subnet01.id
}

# resource "azurerm_network_interface" "interface01" {
#   name                = "interface01" # can be same
#   location            = local.resource_location # can be same - but defined in difference files
#   resource_group_name = azurerm_resource_group.nonprod_rg.name # how to get this resource group name?

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnet01.id # how to get this subnet id?
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id = azurerm_public_ip.ip01.id # how to get this ip?
#   }
# }

# resource "azurerm_public_ip" "ip01" {
#   name                = "ip01"
#   resource_group_name = azurerm_resource_group.nonprod_rg.name
#   location            = local.resource_location
#   allocation_method   = "Static"
# }

# resource "azurerm_network_security_group" "app_nsg" {
#   name                = "app-nsg"
#   location            = local.resource_location
#   resource_group_name = azurerm_resource_group.nonprod_rg.name

#   security_rule {
#     name                       = "AllowRDP"
#     priority                   = 300
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "3389"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# // https://registry.terraform.io/providers/hashicorp/Azurerm/3.29.0/docs/resources/network_security_group

# resource "azurerm_subnet_network_security_group_association" "subnet01_app_nsg" {
#   subnet_id                 = azurerm_subnet.subnet01.id
#   network_security_group_id = azurerm_network_security_group.app_nsg.id
# }

# // https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

# resource "azurerm_windows_virtual_machine" "vm01" {
#   name                = "vm01"
#   resource_group_name = azurerm_resource_group.nonprod_rg.name
#   location            = local.resource_location
#   size                = "Standard_B2s"
#   admin_username      = "appadmin"
#   admin_password      = "Azure@123"
#   network_interface_ids = [
#     azurerm_network_interface.interface01.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2022-Datacenter"
#     version   = "latest"
#   }
# }
