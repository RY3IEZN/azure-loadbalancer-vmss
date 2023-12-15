# ---root/variables.tf---

variable "enviroment" {
  type        = string
  description = "the name of the enviroment"
  default     = ""
}

variable "address_space" {
  type        = string
  description = "the address space of the vpc"
  default     = "192.168.0.0/16"
}

variable "subnet_address_space" {
  type        = string
  description = "the address space of the subnet"
  default     = "192.168.2.0/24"
}
