# ---networking/networking.tf---

# create resource group
resource "azurerm_resource_group" "az_alb_rg" {
  name     = "az_alb_rg"
  location = "UK South"

  tags = {
    uneku = "${var.enviroment}-rg"
  }
}

# create a virtual network
resource "azurerm_virtual_network" "az_alb_vn" {
  name                = "az_alb_vn"
  location            = azurerm_resource_group.az_alb_rg.location
  resource_group_name = azurerm_resource_group.az_alb_rg.name
  address_space       = [var.address_space]


  tags = {
    uneku = "${var.enviroment}-vn"
  }
}

# Create a Subnet
resource "azurerm_subnet" "az_alb_vm_subnet" {
  name                 = "az_alb_vm_subnet"
  resource_group_name  = azurerm_resource_group.az_alb_rg.name
  virtual_network_name = azurerm_virtual_network.az_alb_vn.name
  address_prefixes     = [var.subnet_address_space]
}


