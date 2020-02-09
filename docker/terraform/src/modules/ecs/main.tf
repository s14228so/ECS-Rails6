resource "aws_ecs_cluster" "of_ecs_rails" {
  name = "rails-api"
}

resource "aws_ecs_task_definition" "of_ecs_rails" {
  family                = "rails-nginx-task" #タスク名
  container_definitions = file("modules/ecs/container-definitions.json")

  volume {
    name      = "sockets"
    docker_volume_configuration {
      scope         = "task"
      driver        = "local"
    }
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}


resource "aws_ecs_service" "of_ecs_rails" {
  name            = "rails-service"
  cluster         = aws_ecs_cluster.of_ecs_rails.id
  task_definition = aws_ecs_task_definition.of_ecs_rails.arn
  desired_count   = 2
  scheduling_strategy = "REPLICA"
  launch_type = "EC2"

  load_balancer {
    target_group_arn = var.alb_tg_arn
    container_name   = "nginx"
    container_port   = 80
  }
}