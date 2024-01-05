#!/bin/sh
sudo apt-get update
sudo apt-get install -y default-jdk
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins
wget https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.11/jenkins-plugin-manager-2.12.11.jar -P /tmp/
sudo java -jar /tmp/jenkins-plugin-manager-2.12.11.jar --war /usr/share/java/jenkins.war -d /var/lib/jenkins/plugins --plugin-file /tmp/plugins.txt
sudo systemctl restart jenkins.service
sudo mkdir /etc/systemd/system/jenkins.service.d
sudo cp /tmp/override.conf /etc/systemd/system/jenkins.service.d/override.conf
sudo systemctl daemon-reload
sudo systemctl restart jenkins.service