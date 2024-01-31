variable "cidr_block" {
  description = "CIDR block for the VPC"

}
variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
}
variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for  private subnets"
}
variable "avail_zone" {
  type        = list(string)
  description = "List of availability zones"
}
variable "env_prefix" {

}
variable "total_count" {

}
variable "ami_id" {

}
variable "instance_type" {

}

variable "public_keylocation" {
  
}
