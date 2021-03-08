resource "aws_security_group" "ecs-securitygroup" {
    vpc_id      = aws_vpc.main.id
    name        = "ecs"
    description = "security group for ecs"
    egress  {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }


    ingress {
      from_port = 80
      protocol = "tcp"
      security_groups = [aws_security_group.ersl-admin-console-dev2-elb-securitygroup.id]
      to_port = 80
    }

    ingress {
      from_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      to_port = 80
    }
}

resource "aws_security_group" "ersl-admin-console-dev2-elb-securitygroup" {
    vpc_id      = aws_vpc.main.id
    name        = "ersl-admin-console-dev2-elb"
    description = "security group for ecs"
    egress  {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      to_port = 80
    }
    tags = {
        Name = "aws_security_group.ersl-admin-console-dev2-elb"
    }
}