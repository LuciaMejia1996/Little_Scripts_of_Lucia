#!/bin/bash
sudo service mysql stop  #or mysqld
sudo killall -9 mysql
sudo killall -9 mysqld
sudo apt-get remove --purge mysql-server mysql-client mysql-common -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo deluser mysql
sudo rm -rf /var/lib/mysql
#sudo apt-get purge mysql-server-core-8.0.29
#sudo apt-get purge mysql-client-core-8.0.29
