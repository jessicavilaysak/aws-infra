
#!/bin/bash -xe
date

aws configure set default.region ap-southeast-2
yum install jq -y
sudo -E yum install java-1.8.0-openjdk-devel -y
yum remove java-1.7.0-openjdk -y
sudo -E yum install httpd -y
yum -y install git
yum update

#############################################################################################################
### Installing jenkins
#############################################################################################################
wget -O /etc/yum.repos.d/jenkins.repo "${jenkins_repo_download_link}"
rpm --import "${jenkins_repo_import_link}"
yum install jenkins -y

#############################################################################################################
### Set up git connectivity
#############################################################################################################
priv_key_json=$(aws ssm get-parameter --with-decryption --name "/github/srv_jess/privatekey")
priv_key_val=$(jq -r '.Parameter.Value' <<< "$priv_key_json")
echo $priv_key_val > "${jenkins_ssh_folder_path}/id_rsa"
# the private key MUST be 600 and owned by jenkins
chmod 600 "${jenkins_ssh_folder_path}/id_rsa"
chown jenkins:jenkins "${jenkins_ssh_folder_path}/id_rsa"

pub_key_json=$(aws ssm get-parameter --with-decryption --name "/github/srv_jess/publickey")
pub_key_val=$(jq -r '.Parameter.Value' <<< "$pub_key_json")
echo $pub_key_val > "${jenkins_ssh_folder_path}/id_rsa.pub"
# the public key MUST be 644 and owned by jenkins
chmod 644 "${jenkins_ssh_folder_path}/id_rsa.pub"
chown jenkins:jenkins "${jenkins_ssh_folder_path}/id_rsa.pub"

