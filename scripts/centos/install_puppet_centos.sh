#!/bin/bash

sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
sudo yum install -y puppet-agent
echo -e "192.168.11.10\tmaster puppet" | sudo tee -a /etc/hosts
