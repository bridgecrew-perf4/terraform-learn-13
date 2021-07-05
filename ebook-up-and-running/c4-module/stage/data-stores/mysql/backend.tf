terraform {
    backend "s3" {
        bucket = "terraform-up-and-running-state-ngoctp27"
        key = "stage/data-stores/mysql/terraform.tfstate"
        region = "ap-southeast-1"
    }
}