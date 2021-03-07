resource "aws_security_group" "allow-mariadb" {
    vpc_id          = aws_vpc.main.id
    name            = "allow-mariadb"
    description     = "allow-mariadb"
    ingress {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "db for everyone"
      from_port = 3306
      protocol = "tcp"
      self = false
      to_port = 3306
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