#!/bin/bash

############ Fail2ban
apt install -y fail2ban
custom=/etc/fail2ban/jail.local

echo "[sshd]" > $custom
echo "port = 16" >> $custom
echo "logpath = /var/log/auth.log" >> $custom
echo "backend = %(sshd_backend)s" >> $custom
echo "maxretry = 3" >> $custom

