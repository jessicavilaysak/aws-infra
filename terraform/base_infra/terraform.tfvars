#-------- Mandatory tagging
tags_costcentre = ""
tags_applicationID = ""
tags_owner = ""
tags_powermgmt = ""
tags_environment = ""
## We will use this whenever we want to refer to this terraform project's name
tags_executedby = "TERRAFORM_HAWKS"
tags_ldap_authgroup = ""
tags_ldap_domain = ""

## These tags are taken from ThunderHead's sample
# terraform.tfvars:21:tags_group                = "FSD_DEVOPS"
# terraform.tfvars:22:tags_hip_instance_type    = "DEMO"
# terraform.tfvars:24:tags_instanceName         = "PACKER_JENKINS"
# terraform.tfvars:49:tags_bastion_instanceName    = "PACKER_BASTION"
# terraform.tfvars:58:tags_jenkins_lb_name="OCDDEVOPSJENKINS_ELB"
# terraform.tfvars:62:tags_special_jenkins_asg_name="OCDDEVOPSJENKINS_ASG"
# terraform.tfvars:72:tags_EFSName = "OCDDevOpsJenkins-EFS_NEW"
# terraform.tfvars:81:tags_sonarqubeDB_instanceName = "SonarQube Database"





#--------- Any global vars
region = "ap-southeast-2"
tools_vpc_id = "vpc-99b0e5fe"
ssh_port = "22"
http_port = "8080"
https_port = "8443"
subnet_ids = [
    "subnet-2637196f",
    "subnet-a9fac7ce",
    "subnet-231bb77b"
]
subnet_id = "subnet-2637196f"
ami_owner_amazon = "amazon"


#---------- Vars for module 'roles'
bastion_iam_role_name = "BastionInstanceRole"
bastion_iam_profile_name = "BastionInstanceProfile"
jenkins_iam_role_name = "JenkinsInstanceRole"
jenkins_iam_profile_name = "JenkinsInstanceProfile"



## Vars for S3 backend - cannot be used bc vars apparently aren't allowed in the s3 backend section
#s3_backend_bucket = "9328-test-bucket"
#s3_backend_bucket_path = "jenkins-poc-stack/terraform.tfstate"


#---------- Vars for module 'security_groups'
bastion_tooling_sg_name = "ToolingBastionSecurityGroup"
jenkins_tooling_sg_name = "ToolingJenkinsSecurityGroup"
jenkins_tooling_lb_sg_name = "ToolingJenkinsLoadBalancerSG"
all_inbound_cidrs = ["0.0.0.0/0"]
all_outbound_cidrs = ["0.0.0.0/0"]


#----------- Vars for module 'computing'
lb_cert_arn = "arn:aws:iam::024487289407:server-certificate/jess-test-jenkins"
ami_filter_name = "name"
ami_filter_pattern_bastion = "amzn2-ami-hvm-*-x86_64-gp2"
ami_filter_pattern_jenkins = "amzn2-ami-hvm-*-x86_64-gp2"
bastion_instance_type = "t2.micro"
jenkins_instance_type = "t2.micro"
key_pair = "jess-root-user"
jenkins_repo_download_link = "https://pkg.jenkins.io/redhat-stable/jenkins.repo"
jenkins_repo_import_link = "https://pkg.jenkins.io/redhat-stable/jenkins.io.key"
ssm_github_priv_key = "/github/srv_jess/privatekey"
ssm_github_pub_key = "/github/srv_jess/publickey"
jenkins_ssh_folder_path = "/var/lib/jenkins/.ssh"