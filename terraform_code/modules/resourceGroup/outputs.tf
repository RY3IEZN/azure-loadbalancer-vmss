# ---rg/outputs.tf---

output "rg_name" {
  value = azurerm_resource_group.az_alb_rg.name
}

output "rg_location" {
  value = azurerm_resource_group.az_alb_rg.location
}
