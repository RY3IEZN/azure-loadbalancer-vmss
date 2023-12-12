# ---root/main.tf---


module "networking" {
  source               = "./modules/networking"
  enviroment           = var.enviroment
  address_space        = var.address_space
  subnet_address_space = var.subnet_address_space
}
