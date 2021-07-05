output "ip_instance" {
    value       = aws_instance.example.public_ip
    description = "The domain name of he load balancer"
}