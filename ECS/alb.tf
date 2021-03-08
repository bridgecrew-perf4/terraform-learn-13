resource "aws_lb" "ersl-admin-console-dev2-alb" {
    name                = "ersl-admin-console-dev2-alb"
    load_balancer_type  = "application"
    subnets             = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
    security_groups     = [aws_security_group.ersl-admin-console-dev2-elb-securitygroup.id]
}

resource "aws_lb_listener" "http" {
    load_balancer_arn   = aws_lb.ersl-admin-console-dev2-alb.arn
    port                = 80
    protocol            = "HTTP"

    default_action {
        type = "fixed-response"
        
        fixed_response {
            content_type    = "text/plain"
            message_body    = "404: page not found"
            status_code      = 404
        }
    }
}

resource "aws_lb_listener_rule" "asg" {
    listener_arn    = aws_lb_listener.http.arn
    priority        = 100

    condition {
        path_pattern {
            values  = ["*"]
        }
    }

    action {
        type               = "forward"
        target_group_arn   = aws_lb_target_group.asg.arn # Assign to Load Balancer Field at "Target Groups"
    }
}

resource "aws_lb_target_group" "asg" {
    name        = "ersl-admin-console-dev2-alb"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.main.id

    health_check {
        path                    = "/favicon.ico"
        protocol                = "HTTP"
        matcher                 = "200"
        interval                = 15
        timeout                 = 3
        healthy_threshold       = 2
        unhealthy_threshold     = 2
    }
}
