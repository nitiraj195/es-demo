###############################################
# Common Variables
###############################################

variable "subnet_id" {}
variable "region" {
  default = "us-east-1"
}
variable "name" {}
variable "key_name" {}
variable "bucket" {}
variable "key" {}

###############################################
# Elasticsearch Variables
###############################################
variable "elasticsearch_ips" {}

########################################
### CIDR blocks
#######################################
variable "access_cidr" {}


######################

variable "elasticsearch_instance_type" {
  default = "c5a.large"
}

