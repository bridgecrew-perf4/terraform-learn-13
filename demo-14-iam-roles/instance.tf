resource "aws_instance" "example" {
    ami             = lookup(var.AMIS, var.AWS_REGION)
    instance_type   = "t2.micro"

    subnet_id       = aws_subnet.main-public-1.id

    vpc_security_group_ids = [aws_security_group.example-instance.id]
    key_name        = "https-tls"

    iam_instance_profile = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name
}

resource "aws_security_group" "example-instance" {
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