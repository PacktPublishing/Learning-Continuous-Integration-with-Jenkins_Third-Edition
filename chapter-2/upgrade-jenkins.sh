
#!/bin/sh
# Stop the Jenkins service.
sudo systemctl stop jenkins.service

# Delete the last jenkins.war backup
rm -r jenkins.war.old

# Take the backup of the current jenkins.war binary.
cd /usr/share/jenkins
mv jenkins.war jenkins.war.old

#Download the new jenkins.war file using the following commands:
wget https://get.jenkins.io/war-stable/<jenkins version>/jenkins.war
chown jenkins:jenkins jenkins.war

# Start the Jenkins service:
sudo systemctl start jenkins.service
