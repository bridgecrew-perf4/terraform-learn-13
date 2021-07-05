module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name = "webserver-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-ngoctp27"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
  instance_type = "t2.micro"
  min_size = 1
  max_size = 2
}

locals {
  http_port = 80
  any_port = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type                = "ingress"
  security_group_id   = module.webserver_cluster.alb_security_group_id

  from_port           = 12345
  to_port             = 12345
  protocol            = "tcp"
  cidr_blocks         = ["0.0.0.0/0"]
}