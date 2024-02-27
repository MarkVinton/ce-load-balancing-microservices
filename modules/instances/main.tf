resource "aws_instance" "public_app" {
    count = length(var.subnet_id)
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.subnet_id[count.index]
  key_name = "key-ED25519"	
  ami = "ami-0505148b3591e4c07"
  associate_public_ip_address = true
  tags = {
    Name = "app_server_00${count.index}"
  }
}
resource "aws_instance" "private_app" {
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.private_subnet_id[0]
  key_name = "key-ED25519"	
  ami = "ami-0505148b3591e4c07"
  associate_public_ip_address = true
  tags = {
    Name = "app_server_004"
  }
}