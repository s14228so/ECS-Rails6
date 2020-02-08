resource "aws_ecs_cluster" "of_ecs_rails" {
  name = "rails-api"
}

resource "aws_ecs_task_definition" "of_ecs_rails" {
  family = "docker_registry"
  container_definitions = file("task-definition.json")
}

resource "aws_ecs_service" "of_ecs_rails" {
  name = "rails-service"
  cluster = aws_ecs_cluster.of_ecs_rails.id
  task_definition = aws_ecs_task_definition.docker_registry.arn
  desired_count = 1
}