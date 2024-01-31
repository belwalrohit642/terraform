variable "vpc_id" {
  description = "ID of the VPC"
}

variable "env_prefix" {

}
# variable "public_subnet_cidr_blocks" {

# }
# variable "private_subnet_cidr_blocks" {

# }
variable "public_subnet_ids" {
  type    = list(string)
  default = []
}

variable "private_subnet_ids" {
  type    = list(string)
  default = []
}
variable "my_internet_gateway" {
  type = any
}
