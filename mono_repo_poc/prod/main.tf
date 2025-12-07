resource "azurerm_resource_group" "prod_rg" {
  name     = local.resource_group_name
  location = local.resource_location
}

resource "azurerm_virtual_network" "prod_network" {
  name                = "app-network"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.prod_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet01" {
  name                 = "subnet01"
  resource_group_name  = azurerm_resource_group.prod_rg.name
  virtual_network_name = azurerm_virtual_network.prod_network.name
  address_prefixes     = ["10.0.0.0/24"]
}

# # Get the vendor's Resource Group
# data "azurerm_resource_group" "prod_rg" {
#   name = "prod-rg"  # The actual deployed RG name
# }

# output prod_rg_id {
#     value=data.azurerm_resource_group.prod_rg.id
# }

# data "azurerm_virtual_network" "prod_network" {
#   name                = "app-network"
#   resource_group_name = data.azurerm_resource_group.prod_rg.name
# }

# output prod_network_name {
#     value=data.azurerm_virtual_network.prod_network.name
# }

# # Get the vendor's Subnet
# data "azurerm_subnet" "subnet01" {
#   name                 = "subnet01"
#   virtual_network_name = data.azurerm_virtual_network.prod_network.name
#   resource_group_name  = data.azurerm_resource_group.prod_rg.name
# }

# output subnet_id {
#     value=data.azurerm_subnet.subnet01.id
# }

