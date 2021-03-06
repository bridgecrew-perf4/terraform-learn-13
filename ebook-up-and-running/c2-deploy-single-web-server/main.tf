resource "aws_instance" "example" {
    ami                     = "ami-070fd30ad040f363e"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group.instance.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World $(hostname -f)" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

    tags = {
        Name = "terraform-example"
    }
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"

    ingress {
        from_port   = var.server_port
        to_port     = var.server_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow_http_8080"
    }
}