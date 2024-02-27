output "public_target" {
  value = aws_lb_target_group.public[*]
}