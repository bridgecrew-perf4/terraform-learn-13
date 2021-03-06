variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map
  default = {
    us-west-2 = "ami-025102f"
    us-east-1 = "ami-02fe94dee086c0c37"
    eu-west-1 = "ami-0e5657f"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "testkey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "testkey.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}