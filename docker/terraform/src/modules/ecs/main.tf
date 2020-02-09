

resource "aws_ecs_cluster" "of_ecs_rails" {
  name = "rails-api"
}

resource "aws_security_group" "of_ecs_cluster" {
  name = "ecs-sg"
  description = "Defilne of SG for ECS Cluster"
  ingress {
    from_port = 1
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags  = {
    Name = "ecs-sg"
  }
}

  # セキュリティグループルール(SSHインバウンド)の定義
  resource "aws_security_group_rule" "of_ssh_ingress"{
    type = "ingress" #インバウンド
    from_port = var.ssh_port
    protocol = "tcp"
    security_group_id = aws_security_group.of_ecs_cluster.id
    to_port =  var.ssh_port
    cidr_blocks = var.cidr_blocks
    description = "ssh inbound of SG for public"
  }


  # セキュリティグループルール(SSHインバウンド)の定義
  resource "aws_security_group_rule" "of_alb_ingress"{
    type = "ingress" #インバウンド
    from_port = var.alb_port
    protocol = "tcp"
    security_group_id = aws_security_group.of_ecs_cluster.id
    source_security_group_id = aws_security_group.of_ecs_cluster.id
    to_port =  var.alb_port
    description = "alb inbound of SG for public"
  }


  resource "aws_security_group_rule" "of_http_ingress"{
    type = "ingress" #インバウンド
    from_port = var.http_port
    protocol = "tcp"
    security_group_id = aws_security_group.of_ecs_cluster.id
    to_port =  var.http_port
    cidr_blocks = var.cidr_blocks
    description = "HTTP inbound of SG for public"
  }

  resource "aws_security_group_rule" "of_rds_ingress"{
    type = "ingress" #インバウンド
    from_port = var.rds_port
    protocol = "tcp"
    security_group_id = aws_security_group.of_ecs_cluster.id
    source_security_group_id = aws_security_group.of_ecs_cluster.id
    to_port =  var.rds_port
    description = "rds inbound of SG for private"
  }




resource "aws_launch_configuration" "of_ecs_rails" {
  name                 = "ecs"
  image_id             = "ami-8aa61c8a"
  instance_type        = "t3.medium"
  key_name             = "aws-ec2"
  security_groups      = [aws_security_group.of_ecs_cluster.id]
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