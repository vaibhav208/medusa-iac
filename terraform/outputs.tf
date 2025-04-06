output "load_balancer_dns" {
  value = aws_lb.medusa.dns_name
}
