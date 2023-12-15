# ---root/main.tf---


module "networking" {
  source               = "./modules/networking"
  enviroment           = var.enviroment
  address_space        = var.address_space
  subnet_address_space = var.subnet_address_space
  rg_name              = module.resource_group.rg_name
  rg_location          = module.resource_group.rg_location
}

module "compute" {
  source                             = "./modules/compute"
  public_subnet_id                   = module.networking.public_subnet_id
  rg_name                            = module.resource_group.rg_name
  rg_location                        = module.resource_group.rg_location
  azurerm_lb_backend_address_pool_id = module.loadbalancer.azurerm_lb_backend_address_pool_id
  user_data                          = "userdata.tpl"
}

module "loadbalancer" {
  source      = "./modules/loadbalancer"
  rg_name     = module.resource_group.rg_name
  rg_location = module.resource_group.rg_location
}

module "resource_group" {
  source      = "./modules/resourceGroup"
  enviroment  = "root"
  rg_name     = "az_alb_rg"
  rg_location = "UK South"
}
