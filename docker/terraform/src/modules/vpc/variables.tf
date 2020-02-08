
variable "vpc_cider" {
  type = string
  default = "10.0.0.0/16"
  description  = "VPCのCIDR"
  
}

variable "vpc_name" {
  type = string
  default = "ecs-terraform-vpc"
  description = "VPCの名前"
}

variable "az_names" {
  type = map(string)
  default = {
    "1a" = "ap-northeast-1a"
    "1c" = "ap-northeast-1c"
    "1d" = "ap-northeast-1d"
  }
  description = "AZの名前"
}

variable "public_subnet_1a_name" {
  type = string
  default = "public_subnet_1a"
  description = "パブリックサブネットの名前"
}

variable "igw_name" {
  type = string
  default = "ecs_terraform_igw"
  description = "インターネットゲートウェイの名前"
}

variable "route_table_name" {
  type = string
  default = "ecs_terraform_route_table"
  description = "ルートテーブルの名前"
}


variable "cidr_blocks" {
  type = list(string) #配列
  default = ["0.0.0.0/0"]
  description = "CIDRのデフォルトのIPアドレス"
}

variable "sg_name" {
  type = string
  default = "terraform_handson_on_docker_sg"
  description = "セキュリティグループの名前"
}

variable "ssh_port" {
  type = number
  default = 22
  description = "SSHポートのデフォルト値"
}