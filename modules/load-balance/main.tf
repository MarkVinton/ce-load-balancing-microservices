resource "aws_lb_target_group" "public" {
    count = length(var.names)
  name = var.names[count.index]
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check {
    path = "/health-check"
    protocol = "HTTP"
  }
}
resource "aws_lb_target_group" "private" {
    name= "auth"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check {
    path = "/health-check"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "public_attachment" {
    count = length(aws_lb_target_group.public)
  target_group_arn = aws_lb_target_group.public[count.index].arn
  target_id = var.public_instance[count.index]
  port = 3000
}
resource "aws_lb_target_group_attachment" "private_attachment" {
  target_group_arn = aws_lb_target_group.private.arn
  target_id = var.private_instance[0]
}
