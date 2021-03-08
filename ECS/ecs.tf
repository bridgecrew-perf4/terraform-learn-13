data "template_file" "ersl-admin-console-dev2-task-definiton-template" {
    template        = file("templates/app.json.tpl")
    vars = {
        REPOSITORY_URL = replace(data.aws_ecr_repository.ersl-admin-console-dev2.repository_url, "https://","")
    }
}

resource "aws_ecs_task_definition" "ersl-admin-console-dev2-task-definiton" {
    family = "ersl-admin-console-dev2"
    container_definitions = data.template_file.ersl-admin-console-dev2-task-definiton-template.rendered
}
###
resource "aws_ecs_service" "ersl-admin-console-dev2-service" {
    name            = "ersl-admin-console-dev2"
    cluster         = aws_ecs_cluster.example-cluster.id
    task_definition = aws_ecs_task_definition.ersl-admin-console-dev2-task-definiton.arn
    desired_count   = 1
    iam_role        = aws_iam_role.ecs-service-role.arn
    depends_on      = [aws_iam_policy_attachment.ecs-service-attach1, aws_lb_listener_rule.asg]

    load_balancer {
        target_group_arn = aws_lb_target_group.asg.arn
        container_name = "ersl-admin-console-dev2"
        container_port = 80
    }
    lifecycle {
      ignore_changes = [task_definition]
    }
}