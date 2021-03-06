resource "aws_instance" "example" {
    ami = lookup(var.AMIS, var.AWS_REGION)
    instance_type = "t2.micro"

    # the VPC subnet
    subnet_id = aws_subnet.main-public-1.id

    # the security group
    vpc_security_group_ids = [aws_security_group.allow-ssh.id]

    # the public key
    key_name = aws_key_pair.mykeypair.key_name
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "ap-southeast-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.example.id
}

resource "aws_security_group" "allow-ssh" {
    vpc_id = aws_vpc.main.id
    name = "allow-ssh"
    description = "security group that allows ssh and all egress traffic"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 22
      protocol = "tcp"
      to_port = 22
    } 

    tags = {
      "Name" = "allow-ssh"
    }
}