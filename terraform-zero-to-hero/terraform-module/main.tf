module "dev" {
    source = "./module"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
}