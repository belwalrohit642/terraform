resource "aws_internet_gateway" "ninja-igw-01" {
  vpc_id = var.vpc_id
  tags = {
    Name : "${var.env_prefix}-igw"
  }
}
output "my_internet_gateway" {
  value = aws_internet_gateway.ninja-igw-01.id
}