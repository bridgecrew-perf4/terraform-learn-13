resource "aws_s3_bucket" "b" {
    bucket    = "mybucket-f23sc8"
    acl     = "private"

    tags = {
      Name = "mybucket-f23sc8"
    }
}