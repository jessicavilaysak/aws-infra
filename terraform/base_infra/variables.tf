#------------ Common vars across all modules
variable "region" {}
variable "tools_vpc_id" {}
variable "ssh_port" {}
variable "http_port" {}
variable "https_port" {}


#--------------- Tag vars to be used
variable "tags_costcentre" {}
variable "tags_applicationID" {}
variable "tags_owner" {}
variable "tags_powermgmt" {}
variable "tags_environment" {}
variable "tags_executedby" {}
variable "tags_ldap_authgroup" {}
variable "tags_ldap_domain" {}




#----------- Vars for module 'roles'
variable "bastion_iam_role_name" {}
variable "bastion_iam_profile_name" {}
variable "jenkinsmaster_iam_role_name" {}
variable "jenkinsmaster_iam_profile_name" {}


#------------ Vars for module 'security_groups'
variable "bastion_tooling_sg_name" {}
variable "jenkins_tooling_sg_name" {}
variable "jenkins_tooling_lb_sg_name" {}
variable "all_inbound_cidrs" {}
variable "all_outbound_cidrs" {}