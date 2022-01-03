#!/bin/bash
set -e

# Install necessary dependencies
sudo apt -y -qq install fish
mkdir hello
echo "made with terraform " > hello/index.txt
echo "hello Terraform" > /etc/motd