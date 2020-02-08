# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.of_ecs_rails.id
}

# Subnets
output "public_subnets" {
  description = "List of IDs of private subnets"
  value       = [aws_subnet.of_ecs_public_1a.id,aws_subnet.of_ecs_public_1c.id]
}

output "private_subnets" {
  description = "List of IDs of public subnets"
  value       = [aws_subnet.of_ecs_public_1a.id,aws_subnet.of_ecs_private_1c.id]
}

