
#!/bin/bash -xe
date
export http_proxy=http://forwardproxy:3128
export HTTP_PROXY=http://forwardproxy:3128
export https_proxy=http://forwardproxy:3128
export HTTPS_PROXY=http://forwardproxy:3128
export no_proxy=$no_proxy,169.254.169.254,pkg.jenkins-ci.org,*.ap-southeast-2.compute.internal
export NO_PROXY=$no_proxy,169.254.169.254,pkg.jenkins-ci.org,*.ap-southeast-2.compute.internal,*.ap-southeast-2.compute.internal
echo "proxy=http://forwardproxy:3128" >> /etc/yum.conf
echo "proxy=http://forwardproxy:3128" >> /etc/profile
source /etc/profile.d/proxy.sh

yum install jq -y
sudo -E yum install java-1.8.0-openjdk-devel -y
yum remove java-1.7.0-openjdk -y

sudo -E yum install httpd -y

#############################################################################################################
### Installing jenkins
#############################################################################################################
wget -O /etc/yum.repos.d/jenkins.repo "${jenkins_repo_download_link}"
rpm --import "${jenkins_repo_import_link}
yum install jenkins -y
echo "proxy=http://forwardproxy:3128" >> /etc/yum.repos.d/jenkins.repo
