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
  default     = ["us-east-1a", "us-east-1b"]
}
variable "env_prefix" {

}
variable "vpc_id" {
  description = "ID of the VPC"
}
