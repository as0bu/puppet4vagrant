#!/bin/bash

sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
sudo yum install -y puppetserver
sudo rm -rf /etc/puppetlabs/code/environments/production
sudo ln -s /vagrant/environments/production /etc/puppetlabs/code/environments/
echo "autosign = true" | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
echo -e "192.168.11.10\tpuppet" | sudo tee -a /etc/hosts
sudo service puppetserver start
