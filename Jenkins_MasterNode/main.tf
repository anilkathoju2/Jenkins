
data "aws_vpc" "default" {
  default = true
}
  
resource "aws_security_group" "allowall2024" {
    name        = "allowall2024"
    vpc_id = data.aws_vpc.default.id
    description = "allowallports"
    
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    tags = {
        name = "allowall2024"
    }

}

resource "aws_instance" "ec2" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allowall2024.id]


  tags = {
    Name = "Jenkins"
  }
  root_block_device {
        volume_size = 70 #Rootvg disk
        volume_type = "gp3" 

  }
}


