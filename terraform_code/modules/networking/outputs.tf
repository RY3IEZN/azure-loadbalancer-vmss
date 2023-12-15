# ---networking/outputs.tf---


output "public_subnet_id" {
  value = azurerm_subnet.az_alb_vm_public_subnet.id
}
