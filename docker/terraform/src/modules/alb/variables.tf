

variable "vpc_id" {
  description = "The ID of the VPC to create the subnets in"
  type        = string
}

variable "public_subnets" {
  description = "List of IDs of private subnets"
  type       = list(string)
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

