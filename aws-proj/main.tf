resource "aws_vpc" "main" {
  
  cidr_block = var.vpc_cidr_block
  
  tags = {
    Name = "main"
  }

}

resource "aws_subnet" "sub1" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2"

  map_public_ip_on_launch = true

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2"

  map_public_ip_on_launch = true

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  #   route {
  #     ipv6_cidr_block        = "::/0"
  #     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #   }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id =  aws_subnet.sub1.id

  route_table_id = aws_route_table.RT.id

  
}

resource "aws_route_table_association" "rta2" {
  subnet_id =  aws_subnet.sub2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "sg1" {
  name        = "websg"
  description = "Web security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Http anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
      description      = "SSH anywhere"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main"
  }
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "karthikterraform2024proj"
  tags = {
    Name = "main"   
  }
}

resource "aws_instance" "webserver1" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  subnet_id = aws_subnet.sub1.id
  user_data = file("userData.sh")
}

resource "aws_instance" "webserver2" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  subnet_id = aws_subnet.sub1.id
  user_data = file("userData1.sh")
}

