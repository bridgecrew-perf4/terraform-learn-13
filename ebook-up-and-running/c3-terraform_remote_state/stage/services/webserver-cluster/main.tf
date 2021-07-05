data "terraform_remote_state" "db" {
    backend = "s3"

    config = {
      bucket = "terraform-up-and-running-state-ngoctp27"
      key    = "stage/data-stores/mysql/terraform.tfstate"
      region = "ap-southeast-1"
     }
}

data "template_file" "user_data" {
    template = file("user-data.sh")

    vars = {
        server_port = var.server_port
        db_address = data.terraform_remote_state.db.outputs.address
        db_port = data.terraform_remote_state.db.outputs.port
    }
}

resource "aws_instance" "example" {
    ami                     = "ami-0277b52859bac6f4b"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group.instance.id]
    user_data               = data.template_file.user_data.rendered
    key_name                = "https-tls"
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
    ingress {
        from_port   = 22
        to_port     = 22
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