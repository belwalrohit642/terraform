#Automate SSH key pair
resource "aws_key_pair" "ssh-key" {
  key_name   = "server-key"
  public_key = file(var.public_keylocation)
  #This above ssh-key is already exist locally on your machine

}


resource "aws_instance" "public_instance" {
  count         = 1
  ami           = var.ami_id        # Change this to your desired AMI ID
  instance_type = var.instance_type # Change this to your desired instance type

  subnet_id       = var.public_subnet_ids[count.index]
  key_name        = aws_key_pair.ssh-key.key_name
  security_groups = [var.security_groups]
  tags = {
    Name = "PublicInstance"
  }
}

resource "aws_instance" "private_instance" {
  count         = 1
  ami           = var.ami_id        # Change this to your desired AMI ID
  instance_type = var.instance_type # Change this to your desired instance type


  subnet_id       = var.private_subnet_ids[count.index]
  key_name        = aws_key_pair.ssh-key.key_name
  security_groups = [var.security_groups]

  # This instance is in a private subnet, so it won't have a public IP
  associate_public_ip_address = false

  tags = {
    Name = "PrivateInstance"
  }
}

output "public_instance-ip" {
  value = aws_instance.public_instance[0].public_ip
}
output "private_instance_ip" {
  value = aws_instance.private_instance[0].private_ip
}
