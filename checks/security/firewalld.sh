#!/bin/bash

########## Firewalld Installation
apt install -y firewalld
systemctl enable firewalld
systemctl start firewalld

firewall-cmd --permanent --add-port=16/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --permanent --add-port=80/tcp

firewall-cmd --reload

