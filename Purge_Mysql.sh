#!/bin/bash
sudo service mysql stop
sudo killall -9 mysql
sudo apt-get remove --purge mysql-server mysql-client mysql-common -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo deluser mysql
sudo rm -rf /var/lib/mysql

