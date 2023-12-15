# ---networking/networking.tf---

# create a virtual network
resource "azurerm_virtual_network" "az_alb_vn" {
  name                = "az_alb_vn"
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = [var.address_space]


  tags = {
    uneku = "${var.enviroment}-vn"
  }
}

# Create a Subnet
resource "azurerm_subnet" "az_alb_vm_public_subnet" {
  name                 = "az_alb_vm_subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.az_alb_vn.name
  address_prefixes     = [var.subnet_address_space]
}


