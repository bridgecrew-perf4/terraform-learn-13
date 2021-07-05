resource "aws_security_group" "example-instance" {
    vpc_id          = aws_vpc.main.id
    name            = "example-instance"
    description     = "example-instance"
    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 22
      protocol = "tcp"
      to_port = 22
    }

    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "db for everyone"
      from_port = 80
      protocol = "tcp"
      to_port = 80
    }

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        self      = true
    }
    tags = {
        Name = "allow-mariadb"
    }
}