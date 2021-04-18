###############################################
# Common Variables
###############################################
variable "subnet_id" {
  type = string
}

variable "name" {
  type = string
}
variable "key_name" {
  type = string
}
variable "tags" {
  type = map(string)
}

variable "ebs_optimized" {
  type = string
  default = "true"
}
variable "monitoring" {
  type = string
  default = "false"
}
variable "delete_on_termination" {
  type = string
  default = "true"
}
variable "root_volume_type" {
  type = string
  default = "gp2"
}
variable "root_volume_size" {
  type = number
  default = 8
}
variable "region" {
  type = string
  default = "us-east-1"
}

###############################################
# Elasticsearch Variables
###############################################
variable "elasticsearch_ips" {
  type = list
}

variable "elasticsearch_instance_type" {
  type = string
  default = "t2.micro"
}

variable "access_cidr" {
  type = list
  default = ["172.31.0.0/16"]
}
