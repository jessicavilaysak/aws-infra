#---------- global vars

variable "aws_caller_identity" {}
variable "all_inbound_cidrs" {}
variable "all_outbound_cidrs" {}
variable "http_port" {}
variable "https_port" {}
variable "ssh_port" {}
variable "tools_vpc_id" {}


#----------- module specific
variable "bastion_tooling_sg_name" {}
variable "jenkins_tooling_sg_name" {}
variable "jenkins_tooling_lb_sg_name" {}
variable "jenkins_role_name" {}
