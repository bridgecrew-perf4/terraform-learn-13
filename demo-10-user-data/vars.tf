variable "AWS_REGION" {
    default = "ap-southeast-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    ap-southeast-1 = "ami-010e14b2b7ac1b58f"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}