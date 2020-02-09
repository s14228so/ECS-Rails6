# ALBのID
output "alb_id" {
  description = "The ID of the ALB"
  value       = aws_alb.of_ecs.id
}

output "alb_tg_arn" {
  description = "The Name of the ALB Target Group"
  value = aws_alb_target_group.of_ecs.arn
}