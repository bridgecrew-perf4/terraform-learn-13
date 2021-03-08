variable "AWS_REGION" {
  default = "ap-southeast-1"
}

variable "ECS_AMIS" {
  type = map
  default = {
    ap-southeast-1 = "ami-002281dd675dedcbf"
  }
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}