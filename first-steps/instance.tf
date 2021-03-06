provider "aws" {
    access_key = "AKIA3LQMVEOV2RHUW45F"
    secret_key = "qgb9b3GdemOHlIdcYWHcgTl7RZEgo9RoJPMcSblb"
    region     = "us-east-1"
}

resource "aws_instance" "example" {
    ami         = "ami-099e921e69356cf89"
    instance_type        = "t2.micro"
}