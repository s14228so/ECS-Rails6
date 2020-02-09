output "alb_tg_arn" {
  description = "The Name of the ALB Target Group"
  value = aws_alb_target_group.of_ecs.arn
}