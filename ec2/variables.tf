variable "instance_name" {
  description = "Name of instance"
  type        = string
  default     = ""
}
variable "public_ip" {
  description = "enable for public ip"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
variable "subnet_id" {
  description = "Define subnet"
  type        = list(string)
  default     = []
}

variable "ami_id" {
  description = "Define ami_id"
  type        = string
  default     = ""
}
variable "key_name" {
  description = "Key name of Launch instance"
  type        = string
  default     = ""
}
variable "instance_type" {
  description = "define instance type ex- t2.large"
  type        = string
  default     = ""
}
# variable "security_groups" {
#   description = "Define secuity groups"
#   type        = set(string)
#   default     = []
# }

variable "associate_ebs" {
  type        = bool
  description = "Set this to true when you want to use another ebs apart from root"
  default     = false
}
# variable "total_count" {
#   description = "total number of instances"
#   type        = number
# }
variable "public_keylocation" {

}
variable "public_subnet_ids" {

}
variable "private_subnet_ids" {

}
variable "security_groups" {
  type = string
  default = ""
}