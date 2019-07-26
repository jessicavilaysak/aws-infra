## Any global vars
region = "ap-southeast-2"


## Vars for the iam_roles module

bastion_iam_role_name = "BastionInstanceRole"
bastion_iam_profile_name = "BastionInstanceProfile"




## Vars for S3 backend - cannot be used bc vars apparently aren't allowed in the s3 backend section
#s3_backend_bucket = "9328-test-bucket"
#s3_backend_bucket_path = "jenkins-poc-stack/terraform.tfstate"
