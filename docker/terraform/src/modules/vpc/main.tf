# VPCの作成
  resource "aws_vpc" "of_ecs_rails" {
    cidr_block = var.vpc_cider
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = var.vpc_name
    }
  }


  resource "aws_subnet" "of_ecs_public_1a" {
    cidr_block = "10.0.0.0/24"
    vpc_id            = aws_vpc.of_ecs_rails.id
    availability_zone = var.az_names["1a"]
      map_public_ip_on_launch = true
    tags = {
      Name = "ecs-subnet-public-1a"
    }
  }


  resource "aws_subnet" "of_ecs_private_1a" { #private
    cidr_block = "10.0.1.0/24"
    vpc_id            = aws_vpc.of_ecs_rails.id
    availability_zone = var.az_names["1c"]
    tags = {
      Name = "ecs-subnet-public-1a"
    }
  }


  resource "aws_subnet" "of_ecs_public_1c" {
    cidr_block = "10.0.2.0/24"
    vpc_id            = aws_vpc.of_ecs_rails.id
      map_public_ip_on_launch = true
    availability_zone = var.az_names["1c"]
    tags = {
      Name = "ecs-subnet-public-1a"
    }
  }


  resource "aws_subnet" "of_ecs_private_1c" { #private
    cidr_block = "10.0.3.0/24"
    vpc_id            = aws_vpc.of_ecs_rails.id
    availability_zone = var.az_names["1a"]
    tags = {
      Name = "ecs-subnet-public-1a"
    }
  }



  # インターネットゲートウェイの作成

  resource "aws_internet_gateway" "of_public"{
    vpc_id = aws_vpc.of_ecs_rails.id
    tags = {
      Name = var.igw_name
    }
  }

  #　ルートテーブルの定義

  resource "aws_route_table" "of_public"{
    vpc_id = aws_vpc.of_ecs_rails.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.of_public.id

    }
    tags = {
      Name = var.route_table_name
    }
  }

  

  # ルートテーブルとサブネットの関連付け
  resource "aws_route_table_association" "of_public_1a" {
    route_table_id = aws_route_table.of_public.id
    subnet_id = aws_subnet.of_ecs_public_1a.id
  }

  resource "aws_route_table_association" "of_public_1c" {
    route_table_id = aws_route_table.of_public.id
    subnet_id = aws_subnet.of_ecs_public_1c.id
  }


  # セキュリティグループの定義
  resource "aws_security_group" "of_ecs_deploy" {
    name = var.sg_name
    vpc_id = aws_vpc.of_ecs_rails.id
    description = "Defilne of SG for public"
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

  # セキュリティグループルール(SSHインバウンド)の定義
  resource "aws_security_group_rule" "of_ssh_ingress"{
    type = "ingress" #インバウンド
    from_port = var.ssh_port
    protocol = "tcp"
    security_group_id = aws_security_group.of_ecs_deploy.id
    to_port =  var.ssh_port
    cidr_blocks = var.cidr_blocks
    description = "ssh inbound of SG for public"
  }

