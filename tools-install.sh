#!/bin/bash

exec > /var/log/user-data.log 2>&1
set -x

# Update system
sudo apt update -y

# Install Java + tools
sudo apt install -y openjdk-17-jdk curl gnupg

# Add Jenkins key (IMPORTANT FIX)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repo
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

# Update again
sudo apt update -y

# Install Jenkins
sudo apt install -y jenkins

# Start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins