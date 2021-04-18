######################################################
####################  Providers ######################
######################################################

provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
  }
}
provider "ansible" {}

######################################################
####################  Backend ########################
######################################################
terraform {
  backend "s3" {
    bucket            = "var.bucket"
    key               = "var.key"
    region            = "us-east-1"

  }
}

######################################################
################  local variables ####################
######################################################

locals {
  tags = {
    "owner"       = "nitiraj"
    "service"     = "elasticsearch"
  }
}



######################################################
################  elasticsearch     ##################
######################################################

module "elasticsearch" {
  source                      = "./modules/elasticsearch/"
  name                        = var.name
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  elasticsearch_ips           = var.elasticsearch_ips
  tags                        = local.tags
  access_cidr                 = var.access_cidr
  elasticsearch_instance_type = var.elasticsearch_instance_type
}

