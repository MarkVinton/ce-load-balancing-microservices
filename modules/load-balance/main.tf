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
resource "aws_lb" "Micro_lb" {
  name = "Mirco-lb"
  load_balancer_type = "application"
  subnets = var.subnets
  security_groups = [var.security_group_id]
}
resource "aws_lb_listener" "MC_listener_public" {
  load_balancer_arn = aws_lb.Micro_lb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.public[0].arn
  }
}
# resource "aws_lb" "NC_load_balancer" {
#   name ="NC-load-balancer"
#   load_balancer_type = "application"
#   subnets = var.public_subnets
#   security_groups = [var.security_group_id]
# 
# }
# resource "aws_lb_listener" "NC_listener" {
#   load_balancer_arn = aws_lb.NC_load_balancer.arn
#   port = 80
#   protocol = "HTTP"
#   default_action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.CE_target.arn
#   }
# }