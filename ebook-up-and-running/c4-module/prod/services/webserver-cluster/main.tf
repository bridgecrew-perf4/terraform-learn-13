module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webserver-prod"
  db_remote_state_bucket = "terraform-up-and-running-state-ngoctp27"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = t2.micro
  min_size = 2
  max_size = 2
}