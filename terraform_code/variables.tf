variable "enviroment" {
  type        = string
  description = "the name of the enviroment"
  default     = ""
}

variable "address_space" {
  type        = string
  description = "the address space of the vpc"
  default     = ""
}

variable "subnet_address_space" {
  type        = string
  description = "the address space of the subnet"
  default     = ""
}
