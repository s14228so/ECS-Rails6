resource "aws_security_group" "of_alb" {
  name = "alb-sg"
  vpc_id =  var.vpc_id
  description = "Defilne of ALB for public"
  egress { #外に出て行く設定 基本全許可
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = var.cidr_blocks
  }
  tags = {
    Name = var.sg_name
  }
}

resource "aws_security_group_rule" "of_alb" {
  security_group_id = aws_security_group.of_alb.id

  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_alb" "of_ecs" {
  name  = "ecs-loadbalancer"
  security_groups  = [aws_security_group.of_alb.id]
  subnets = var.public_subnets
  internal                   = false
  enable_deletion_protection = false
}


// albのターゲットグループ
resource "aws_alb_target_group" "of_ecs" {
  name     = "alb-tlb-g"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 60
    path                = "/posts"
    protocol            = "HTTP"
    timeout             = 20
    unhealthy_threshold = 4
    matcher             = 200
  }
}

