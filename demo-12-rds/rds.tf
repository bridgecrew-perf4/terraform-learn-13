resource "aws_db_subnet_group" "mariadb-subnet" {
    name = "mariadb-subnet"
    description = "RDS subnet group"
    subnet_ids = [ aws_subnet.main-private-1.id , aws_subnet.main-private-2.id ]
}

resource "aws_db_parameter_group" "mariadb-parameters" {
    name    = "mariadb-parameters"
    family  = "mariadb10.3"
    description = "MariaDB parameter group"

    parameter {
      name  = "max_allowed_packet"
      value = "16777216"
    }
}

resource "aws_db_instance" "mariadb" {
    allocated_storage       = 20
    engine                  = "mariadb"
    engine_version          = "10.3.23"
    instance_class          = "db.t2.micro"
    name                    = "mariadb"
    username                = "admin"
    password                = "var.RDS_PASSWORD"
    db_subnet_group_name    = aws_db_subnet_group.mariadb-subnet.name
    parameter_group_name    = aws_db_parameter_group.mariadb-parameters.name
    multi_az                = "false"
    vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
    storage_type            = "gp2"
    backup_retention_period = "30"
}