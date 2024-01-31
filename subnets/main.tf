resource "aws_subnet" "ninja-pub-sub" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.avail_zone[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet-${count.index + 1}"
  }
}
resource "aws_subnet" "ninja-priv-sub" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.avail_zone[count.index]


  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}
output "public_subnet_ids" {
  value = aws_subnet.ninja-pub-sub[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.ninja-priv-sub[*].id
}
