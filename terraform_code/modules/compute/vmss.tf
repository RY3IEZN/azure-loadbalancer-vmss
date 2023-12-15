# ---compute/vmss.tf---

locals {
  first_public_key = ""

}

resource "azurerm_linux_virtual_machine_scale_set" "az_alb_vmss" {
  name                = "azalbvmss"
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = "Standard_B1s"
  instances           = 3
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = local.first_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.public_subnet_id
      load_balancer_backend_address_pool_ids = [var.azurerm_lb_backend_address_pool_id]
    }
  }

  scale_in {
    force_deletion_enabled = true
  }

  user_data = base64encode(file(var.user_data))
}
