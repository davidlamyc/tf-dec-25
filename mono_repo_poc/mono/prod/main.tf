# Get the vendor's Resource Group
data "azurerm_resource_group" "prod_rg" {
  name = "prod-rg"  # The actual deployed RG name
}

output prod_rg_id {
    value=data.azurerm_resource_group.prod_rg.id
}

data "azurerm_virtual_network" "prod_network" {
  name                = "app-network"
  resource_group_name = data.azurerm_resource_group.prod_rg.name
}

output prod_network_name {
    value=data.azurerm_virtual_network.prod_network.name
}

# Get the vendor's Subnet
data "azurerm_subnet" "subnet01" {
  name                 = "subnet01"
  virtual_network_name = data.azurerm_virtual_network.prod_network.name
  resource_group_name  = data.azurerm_resource_group.prod_rg.name
}

output subnet_id {
    value=data.azurerm_subnet.subnet01.id
}

module "windows_vm" {
  source = "../modules/azure-vm"

  # Required variables
  resource_group_name    = data.azurerm_resource_group.prod_rg.name
  location               = local.resource_location
  subnet_id              = data.azurerm_subnet.subnet01.id
  
  # Naming
  vm_name                = "vm01"
  network_interface_name = "interface01"
  public_ip_name         = "ip01"
  nsg_name               = "app-nsg"
  
  # VM configuration
  vm_size        = "Standard_B2s"
  admin_username = "appadmin"
  admin_password = "Azure@123"  # Consider using Azure Key Vault instead
  
  # Security rules
  security_rules = [
    {
      name                       = "AllowRDP"
      priority                   = 300
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

# Access outputs from the module
output "vm_public_ip" {
  value = module.windows_vm.public_ip_address
}