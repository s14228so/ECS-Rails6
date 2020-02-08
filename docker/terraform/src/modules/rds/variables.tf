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

variable "private_subnets" {
  type = list(string)
  description = "VPCのプライベートサブネットのID配列"
}
