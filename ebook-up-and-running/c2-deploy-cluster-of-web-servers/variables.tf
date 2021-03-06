variable "server_port" {
    description = "The port the server will use for HTTP request"
    type        = number
    default     = 8080
}

output "public_dns" {
    value       = aws_lb.example.dns_name
    description = "The domain name of he load balancer"
}