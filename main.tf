module "vpc" {
  source = "./modules/vpc"

  vpc_name           = "nc_ce_load_balacing_vpc"
  cidr_range         = "10.0.0.0/20"
}

module "subnets" {
  source = "./modules/subnets"
  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnets     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.8.0/24"]
  vpc_name           = "nc_ce_load_balacing_vpc"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.vpc.igw_id
}
module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}
module "instances" {
  source = "./modules/instances"
  security_group_id = module.security.security_group_id
  subnet_id = module.subnets.public_subnets
  private_subnet_id = module.subnets.private_subnets
}
module "load_balance" {
  source = "./modules/load-balance"
  vpc_id = module.vpc.vpc_id
  names = ["heating","lights","status"]
  public_instance = module.instances.instance_ids
  private_instance = module.instances.private_instance_ids
  security_group_id = module.security.security_group_id
  subnets = module.subnets.public_subnets
}

output "dns_name" {
  value = module.load_balance.dns_name
}