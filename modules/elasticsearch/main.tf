#############################################################
# data sources to get vpc, subnet, ami...
#############################################################
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name      = "name"
    values    = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name      = "owner-alias"
    values    = ["amazon"]
  }
}

data "aws_subnet" "selected" {
  id = "${var.subnet_id}"
}

#############################################################
# Create Security Groups
#############################################################
resource "aws_security_group" "elasticsearch-sg" {
  name              = "${var.name}-sg"
  description       = "Security group for elasticsearch  service"
  vpc_id            = data.aws_subnet.selected.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "icmp"
    description     = "ping"
    cidr_blocks     = var.access_cidr
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    description     = "ssh"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    description     = "ssh"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
#############################################################
# Setup Elasticsearch Cluster
#############################################################
resource "aws_instance" "elasticsearch-node" {
  ami                      = data.aws_ami.amazon_linux.id
  count                    = length(var.elasticsearch_ips)
  instance_type            = var.elasticsearch_instance_type
  key_name                 = var.key_name
  ebs_optimized            = var.ebs_optimized
  vpc_security_group_ids   = [aws_security_group.elasticsearch-sg.id]
  subnet_id                = var.subnet_id
  monitoring               = var.monitoring
  lifecycle {
    ignore_changes         = [ami]
  }
  tags = merge(var.tags, {
    "Name"                 = "${var.name}-node-${count.index + 1}",
    "environment"          = "poc"
  })
  volume_tags = merge(var.tags, {
    "Name"                 = "var.name"
  })
  root_block_device {
    volume_type            = var.root_volume_type
    volume_size            = var.root_volume_size
    delete_on_termination  = var.delete_on_termination
  }
}

######################################################
################   Ansible Resources #################
######################################################

resource "ansible_host" "elasticsearch" {
  count                = length(var.elasticsearch_ips)
  inventory_hostname   = aws_instance.elasticsearch-node[count.index].public_ip
  groups               = ["elasticsearch"]
  vars = {
    ansible_user       = "ec2-user"
    become             = "yes"
}
}
