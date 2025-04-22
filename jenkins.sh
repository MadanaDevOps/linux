#!/bin/bash
yum update -y
yum install wget vim tar make unzip -y
yum install java-17-openjdk-devel fontconfig git -y
cd /opt
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
# Add required dependencies for the jenkins package
sudo yum install Jenkins -y
sudo systemctl daemon-reload
firewall-cmd --permanent --add-port=808/tcp
firewall-cmd --reload
sudo systemctl start Jenkins
sudo systemctl enable jenkins
systemctl status Jenkins --no-pager

