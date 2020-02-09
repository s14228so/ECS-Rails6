# AWS設定
provider "aws" {
  # var.awsで参照できる variable.tfに定義してある
  region   = var.aws["region"]
  profile  = var.aws["profile"]
}

module "my_vpc" {
  source = "./modules/vpc"
}

module "my_rds" {
  source = "./modules/rds"
  private_subnets = module.my_vpc.private_subnets
}

module "my_alb" {
  source = "./modules/alb"
  vpc_id = module.my_vpc.vpc_id
  public_subnets = module.my_vpc.public_subnets
}

module "my_ecs" {
  source = "./modules/ecs"
  alb_tg_arn = module.my_alb.alb_tg_arn
  alb_sg_id = module.my_alb.alb_sg_id
}





# terraform init
# terraform plan
# terraform apply (--auto-approve)
# terraform destroy
  


