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

resource "azurerm_network_security_group" "az_alb_nsg" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "nginx"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = var.subnet_address_space
  }

  tags = {
    uneku = "nsg"
  }
}

resource "azurerm_subnet_network_security_group_association" "az_nsg_public_subnet_assoc" {
  subnet_id                 = azurerm_subnet.az_alb_vm_public_subnet.id
  network_security_group_id = azurerm_network_security_group.az_alb_nsg.id
}
