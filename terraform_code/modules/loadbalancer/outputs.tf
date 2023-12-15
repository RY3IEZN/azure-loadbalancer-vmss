# ---loadbalancer/outputs.tf---


output "azurerm_lb_backend_address_pool_id" {
  value = azurerm_lb_backend_address_pool.az_alb_bp.id
}
