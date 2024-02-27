output "instance_ids" {
  value = aws_instance.public_app[*].id
}
output "private_instance_ids" {
  value = aws_instance.private_app[*].id
}