variable "aws" {
  type = map(string)
  default = {
    profile = "default"
    region  = "ap-northeast-1"
  }
}


variable "instance_ami_id" {
  type        = string
  default     = "ami-0ff21806645c5e492"
  description = "EC2インスタンス生成時に指定するデフォルトのAMIのID"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2インスタンスのデフォルトのインスタンスタイプ"
}

variable "aws_key_name" {
  type        = string
  default     = "aws-ec2"
  description = "EC2インスタンスにSSHでアクセスする際に使用するKey名"
}

variable "root_volume_type" {
  type        = string
  default     = "gp2"
  description = "EBSにおけるルートボリュームのデフォルトのtype"
}

variable "root_volume_size" {
  type        = number
  default     = 100
  description = "EBSにおけるルートボリュームのデフォルトのボリューム容量"
}

variable "instance_name" {
  type        = string
  default     = "terraform_handson_on_docker_ec2"
  description = "EC2インスタンスの名前"
}