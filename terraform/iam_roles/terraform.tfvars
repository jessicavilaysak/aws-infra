## Any global vars
region = "ap-southeast-2"


## Vars for the iam_roles module

bastion_iam_role_name = "BastionInstanceRole"
bastion_iam_profile_name = "BastionInstanceProfile"




## Vars for S3 backend
s3_backend_bucket = "9328-test-bucket"
s3_backend_bucket_path = "jenkins-poc-stack/terraform.tfstate"
