variable "alb_tg_arn"{
  description = "The ID of the ALB TG ARN"
  type        = string
}


variable "db_host"{
  default = "\\\"DB_HOST\\\""
}

variable "ssh_port" {
  type = number
  default = 22
  description = "SSHポートのデフォルト値"
}

variable "cidr_blocks" {
  type = list(string) #配列
  default = ["0.0.0.0/0"]
  description = "CIDRのデフォルトのIPアドレス"
}



variable "alb_port" {
  type = number
  default = 32768 - 61000
  description = "ALBポート範囲のデフォルト値"
}

variable "alb_sg_id" {
  type = string
  description = "ALB SGのID"
}

variable "http_port" {
  type = number
   default = 80
  description = "HTTPポートの範囲"
}

variable "rds_port" {
  type = number
   default = 3306
  description = "RDSポートの範囲"
}