output "public_target" {
  value = aws_lb_target_group.public[*]
}
output "dns_name" {
  value = aws_lb.Micro_lb.dns_name
}