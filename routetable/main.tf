resource "aws_route_table" "ninja-route-pub" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.my_internet_gateway
  }

  tags = {
    Name = "${var.env_prefix}-pub-rtb"
  }
}


resource "aws_route_table" "ninja-route-priv" {
  vpc_id = var.vpc_id
  tags = {
    Name : "${var.env_prefix}-prv-rtb"
  }
}

resource "aws_route_table_association" "public_route_association" {
  count          = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.ninja-route-pub.id
}

resource "aws_route_table_association" "private_route_association" {
  count          = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.ninja-route-priv.id
}
data "aws_eip" "my-eip" {
  filter {
    name   = "tag:env"
    values = ["dev"]
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  count         = 1
  subnet_id     = var.public_subnet_ids[1]
  allocation_id = data.aws_eip.my-eip.id


}
# output "my-eip" {
#   value = data.aws_eip.my-eip
# }

# Update the Private Route Table to route traffic through the NAT Gateway
resource "aws_route" "private_route" {
  count = 1

  route_table_id         = element(aws_route_table.ninja-route-priv[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_nat_gateway[0].id
}

output "public_route_table_id" {
  value = aws_route_table.ninja-route-pub.id
}

output "private_route_table_id" {
  value = aws_route_table.ninja-route-priv.id
}
