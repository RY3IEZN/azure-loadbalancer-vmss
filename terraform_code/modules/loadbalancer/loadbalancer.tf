# ---loadbalancer/loadbalancer.tf---

resource "azurerm_public_ip" "az_alb_public_ip" {
  name                = "az-lb-ip"
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "az_alb" {
  name                = "TestLoadBalancer"
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.az_alb_public_ip.id

  }
}

resource "azurerm_lb_backend_address_pool" "az_alb_bp" {
  loadbalancer_id = azurerm_lb.az_alb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_rule" "az_alb_inbound_rule" {
  loadbalancer_id                = azurerm_lb.az_alb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.az_alb_bp.id]
  disable_outbound_snat          = true
}

resource "azurerm_lb_outbound_rule" "az_alb_outbound_rule" {
  name                    = "OutboundRule"
  loadbalancer_id         = azurerm_lb.az_alb.id
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.az_alb_bp.id

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}

resource "azurerm_lb_probe" "az_alb_health_probe" {
  loadbalancer_id = azurerm_lb.az_alb.id
  name            = "health-running-probe"
  port            = 80
  protocol        = "Tcp"
}
