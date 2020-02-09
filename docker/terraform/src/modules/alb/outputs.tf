output "alb_tg_arn" {
  description = "The Name of the ALB Target Group"
  value = aws_alb_target_group.of_ecs.arn
}

output "alb_sg_id" {
  value = aws_security_group.of_alb.id
}