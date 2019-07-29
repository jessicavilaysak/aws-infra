
#!/bin/bash -xe
date


yum install jq -y
sudo -E yum install java-1.8.0-openjdk-devel -y
yum remove java-1.7.0-openjdk -y

sudo -E yum install httpd -y

#############################################################################################################
### Installing jenkins
#############################################################################################################
wget -O /etc/yum.repos.d/jenkins.repo "${jenkins_repo_download_link}"
rpm --import "${jenkins_repo_import_link}"
yum install jenkins -y
echo "proxy=http://forwardproxy:3128" >> /etc/yum.repos.d/jenkins.repo
