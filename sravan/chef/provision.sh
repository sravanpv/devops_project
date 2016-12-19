#!/bin/bash
#
## Install chef
curl -L https://www.opscode.com/chef/install.sh | sudo bash

echo "Provisioning an application node"
sudo chef-solo -c chef/solo.rb -o deploy

echo "Install serverspec"
sudo yum -y install rake
sudo gem install serverspec

echo "=============================== Running Tests ============================"
cd /home/ec2-user/chef
sudo rake spec
