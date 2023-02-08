
# #! /bin/bash
# set -e

# # Ouput all log
# exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1


#!/bin/bash

# Update package index
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
