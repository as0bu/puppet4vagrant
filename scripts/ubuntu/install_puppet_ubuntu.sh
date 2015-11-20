#!/bin/bash

wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
sudo dpkg -i puppetlabs-release-pc1-trusty.deb
sudo apt-get update
sudo apt-get install -y puppet-agent
echo -e "192.168.11.10\tmaster puppet" | sudo tee -a /etc/hosts
#sudo chown -R puppet:puppet /etc/puppetlabs
