#!/bin/bash

wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
sudo dpkg -i puppetlabs-release-pc1-trusty.deb
sudo apt-get update
sudo apt-get install -y puppetserver
sudo chown -R puppet:puppet /etc/puppetlabs
sudo rm -rf /etc/puppetlabs/code/environments/production
sudo ln -s /vagrant/environments/production /etc/puppetlabs/code/environments/
sudo service puppetserver start
