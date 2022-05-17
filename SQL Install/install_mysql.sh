#!/bin/bash
sudo apt update
sudo apt install mysql-server -y
sudo service mysql start
sudo snap install mysql-workbench-community
sudo snap connect mysql-workbench-community:password-manager-service
sudo snap connect mysql-workbench-community:ssh-keys
sudo mysql -u root < script_change_password.sql
