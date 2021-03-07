data "template_file" "ersl-admin-console-dev2-task-definiton-template" {
    template        = file("template/app.json.tpl")
    vars {
        REPOSITORY_URL = replace("${aws_ecr_repository.ersl-admin-console-dev2.repository_url}", "https://","")
    }
}

resource "aws_ecs_task_definition" "ersl-admin-console-dev2-task-definiton" {
    family = "ersl-admin-console-dev2"
    container_definitions = data.template_file.ersl-admin-console-dev2-task-definiton-template.rendered
}

resource "aws_elb" "ersl-admin-console-dev2-elb" {
    name    = "ersl-admin-console-dev2-elb"

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout = 30
        target  = "HTTP:80/favicon.ico"
        interval            = 60
    }

    cross_zone_load_balancing   = false
    idle_timeout = 400
    connection_draining         = true
    connection_draining_timeout = 400

    subnets     = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
    security_groups = [aws_security_group.ersl-admin-console-dev2-elb-securitygroup.id] # ???

    tags {
        Name = "ersl-admin-console-dev2-elb"
    }
}

resource "aws_ecs_service" "ersl-admin-console-dev2-service" {
    name            = "ersl-admin-console-dev2"
    cluster         = aws_ecs_cluster.example-cluster.id
    task_definition = aws_ecs_task_definition.ersl-admin-console-dev2-task-definition.arn
    desired_count   = 1
    iam_role        = aws_iam_role.ecs-service-role.arn
    depends_on      = aws_iam_policy_attachment.ecs-service-attach1

    load_balancer {
        elb_name        = aws_elb.ersl-admin-console-dev2-elb.name
        container_name = "ersl-admin-console-dev2"
        container_port = 80
    }
    lifecycle {
      ignore_changes = ["task_definition"]
    }
}