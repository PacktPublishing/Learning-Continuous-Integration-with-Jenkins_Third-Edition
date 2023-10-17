#!/bin/sh
sudo mkdir /var/lib/jenkins
sudo chown jenkins:jenkins /var/lib/jenkins
sudo mount /dev/sdc1 /var/lib/jenkins
uuid=$(sudo blkid -s UUID -o value /dev/sdc1)
append_string="   /datadrive   xfs   defaults,nofail   1   2"
echo "UUID=$uuid$append_string" | sudo tee -a /etc/fstab