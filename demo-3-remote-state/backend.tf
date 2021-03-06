terraform {
  backend "s3"  {
      bucket = "terraform-state-ff773"
      key    = "terraform/demo-3-remote-state"
  }
}