#!/bin/bash
# Jenkins setup script for AWS EC2 with EBS persistence

set -e

# Variables
JENKINS_HOME="/var/jenkins_home"
DEVICE="/dev/nvme1n1"   # adjust if your EBS shows differently in lsblk

echo ">>> Formatting EBS volume (if not already formatted)..."
sudo mkfs -t ext4 $DEVICE || true

echo ">>> Creating Jenkins home directory..."
sudo mkdir -p $JENKINS_HOME

echo ">>> Mounting EBS volume..."
sudo mount $DEVICE $JENKINS_HOME

echo ">>> Fixing permissions for Jenkins user (UID 1000)..."
sudo chown -R 1000:1000 $JENKINS_HOME

echo ">>> Persisting mount in /etc/fstab..."
grep -q "$DEVICE" /etc/fstab || echo "$DEVICE $JENKINS_HOME ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab

echo ">>> Removing old Jenkins container if exists..."
sudo docker rm -f jenkins || true

echo ">>> Starting Jenkins container with persistent storage..."
sudo docker run -d \
  -p 8080:8080 -p 50000:50000 \
  -v $JENKINS_HOME:/var/jenkins_home \
  --name jenkins \
  jenkins/jenkins:lts

echo ">>> Jenkins setup complete!"
echo "Access Jenkins at: http://<public-ip>:8080"
echo "Admin password:"
sudo docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
