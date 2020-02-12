#!/bin/bash

############# Update & preparation
echo "Package update"
apt update -y
apt install nano -y
mkdir /var/log/report
touch /var/log/report/install.log
mkdir /etc/backup
report=/var/log/report/install.log

############ Permission sudoers.d forlder
chmod 750 /etc/sudoers.d/
chmod 750 /etc/sudoers
############ Configuration SSH
echo "SSH configuration"

cp /etc/ssh/sshd_config /etc/backup/sshd_config.save
sshd_config=/etc/ssh/sshd_config

old_port="#Port 22"
new_port="Port 16"
sed -i "s/$old_port/$new_port/g" $sshd_config

old_AllowTcpForwarding="#AllowTcpForwarding yes"
new_AllowTcpForwarding="AllowTcpForwarding no"
sed -i "s/$old_AllowTcpForwarding/$new_AllowTcpForwarding/g" $sshd_config

old_ClientAliveCountMax="#ClientAliveCountMax 3"
new_ClientAliveCountMax="ClientAliveCountMax 2"
sed -i "s/$old_ClientAliveCountMax/$new_ClientAliveCountMax/g" $sshd_config

old_Compression="#Compression delayed"
new_Compression="Compression no"
sed -i "s/$old_Compression/$new_Compression/g" $sshd_config

old_LogLevel="#LogLevel INFO"
new_LogLevel="LogLevel VERBOSE"
sed -i "s/$old_LogLevel/$new_LogLevel/g" $sshd_config

old_MaxAuthTries="#MaxAuthTries 6"
new_MaxAuthTries="MaxAuthTries 2"
sed -i "s/$old_MaxAuthTries/$new_MaxAuthTries/g" $sshd_config

old_MaxSessions="#MaxSessions 10"
new_MaxSessions="MaxSessions 2"
sed -i "s/$old_MaxSessions/$new_MaxSessions/g" $sshd_config

old_PermitRootLogin="#PermitRootLogin prohibit-password"
new_PermitRootLogin="PermitRootLogin no"
sed -i "s/$old_PermitRootLogin/$new_PermitRootLogin/g" $sshd_config

old_TCPKeepAlive="#TCPKeepAlive yes"
new_TCPKeepAlive="TCPKeepAlive no"
sed -i "s/$old_TCPKeepAlive/$new_TCPKeepAlive/g" $sshd_config

old_X11Forwarding="X11Forwarding yes"
new_X11Forwarding="X11Forwarding no"
sed -i "s/$old_X11Forwarding/$new_X11Forwarding/g" $sshd_config

old_AllowAgentForwarding="#AllowAgentForwarding yes"
new_AllowAgentForwarding="AllowAgentForwarding no"
sed -i "s/$old_AllowAgentForwarding/$new_AllowAgentForwarding/g" $sshd_config

systemctl restart sshd

echo --------------------------------------------     SSH Configuration > $report

verify_ssh() {
check_port_ssh=$(cat $sshd_config | grep -i "Port 16")
if [[ -z $check_port_ssh ]]
then
        echo "PORT SSH --> Failed" >> $report
else
        echo "PORT SSH --> Succes" >> $report
fi
}
verify_ssh

verify_AllowTcpForwarding() {
check_AllowTcpForwarding=$(cat $sshd_config | grep -i "AllowTcpForwarding no")
if [[ -z $check_AllowTcpForwarding ]]
then
	echo "AllowTcpForwarding --> Failed" >> $report
else
	echo "AllowTcpForwarding --> Succes" >> $report
fi
}
verify_AllowTcpForwarding

verify_ClientAliveCountMax() {
check_ClientAliveCountMax=$(cat $sshd_config | grep -i "ClientAliveCountMax 2")
if [[ -z $check_ClientAliveCountMax ]]
then
        echo "ClientAliveCountMax --> Failed" >> $report
else
        echo "ClientAliveCountMax --> Succes" >> $report
fi
}
verify_ClientAliveCountMax

verify_Compression() {
check_Compression=$(cat $sshd_config | grep -i "Compression no")
if [[ -z $check_Compression ]]
then
        echo "Compression --> Failed" >> $report
else
        echo "Compression --> Succes" >> $report
fi
}
verify_Compression

verify_LogLevel() {
check_LogLevel=$(cat $sshd_config | grep -i "LogLevel VERBOSE")
if [[ -z $check_LogLevel ]]
then
        echo "LogLevel --> Failed" >> $report
else
        echo "LogLevel --> Succes" >> $report
fi
}
verify_LogLevel

verify_MaxAuthTries() {
check_MaxAuthTries=$(cat $sshd_config | grep -i "MaxAuthTries 2")
if [[ -z $check_MaxAuthTries ]]
then
        echo "MaxAuthTries --> Failed" >> $report
else
        echo "MaxAuthTries --> Succes" >> $report
fi
}
verify_MaxAuthTries

verify_MaxSessions() {
check_MaxSessions=$(cat $sshd_config | grep -i "MaxSessions 2")
if [[ -z $check_MaxSessions ]]
then
        echo "MaxSessions --> Failed" >> $report
else
        echo "MaxSessions --> Succes" >> $report
fi
}
verify_MaxSessions

verify_PermitRootLogin() {
check_PermitRootLogin=$(cat $sshd_config | grep -i "PermitRootLogin no")
if [[ -z $check_PermitRootLogin ]]
then
        echo "PermitRootLogin --> Failed" >> $report
else
        echo "PermitRootLogin --> Succes" >> $report
fi
}
verify_PermitRootLogin

verify_TCPKeepAlive() {
check_TCPKeepAlive=$(cat $sshd_config | grep -i "TCPKeepAlive no")
if [[ -z $check_TCPKeepAlive ]]
then
        echo "TCPKeepAlive --> Failed" >> $report
else
        echo "TCPKeepAlive --> Succes" >> $report
fi
}
verify_TCPKeepAlive

verify_X11Forwarding() {
check_X11Forwarding=$(cat $sshd_config | grep -i "X11Forwarding no")
if [[ -z $check_X11Forwarding ]]
then
        echo "X11Forwarding --> Failed" >> $report
else
        echo "X11Forwarding --> Succes" >> $report
fi
}
verify_X11Forwarding

verify_AllowAgentForwarding() {
check_AllowAgentForwarding=$(cat $sshd_config | grep -i "AllowAgentForwarding no")
if [[ -z $check_AllowAgentForwarding ]]
then
        echo "AllowAgentForwarding --> Failed" >> $report
else
        echo "AllowAgentForwarding --> Succes" >> $report
fi
}
verify_AllowAgentForwarding
echo --------------------------------------------------------------------->> $report

############ Configuration Login
login=/etc/login.defs

cp /etc/login.defs /etc/backup/login.defs.save

old_PASS_MAX="PASS_MAX_DAYS	99999"
new_PASS_MAX="PASS_MAX_DAYS	365"
sed -i "s/$old_PASS_MAX/$new_PASS_MAX/g" $login

old_PASS_MIN="PASS_MIN_DAYS	0"
new_PASS_MIN="PASS_MIN_DAYS	1"
sed -i "s/$old_PASS_MIN/$new_PASS_MIN/g" $login

old_umask="UMASK		022"
new_umask="UMASK		027"
sed -i "s/$old_umask/$new_umask/g" $login

echo --------------------------------------------     Login configuration >> $report

verify_pass_max() {
check_pass_max=$(cat $login | grep -i "PASS_MAX_DAYS" | grep -i "365")
if [[ -z $check_pass_max ]]
then
        echo "PASS_MAX --> Failed" >> $report
else
        echo "PASS_MMAX --> Succes" >> $report
fi
}
verify_pass_max

verify_pass_min() {
check_pass_min=$(cat $login | grep -i "PASS_MIN_DAYS" | grep -i "1")
if [[ -z $check_pass_min ]]
then
        echo "PASS_MIN --> Failed" >> $report
else
        echo "PASS_MIN --> Succes" >> $report
fi
}
verify_pass_min

verify_umask() {
check_umask=$(cat $login | grep -i "UMASK" | grep -i "027")
if [[ -z $check_umask ]]
then
        echo "UMASK --> Failed" >> $report
else
        echo "UMASK --> Succes" >> $report
fi
}
verify_umask
echo -------------------------------------------------------------------------------------------------------------------------- >> $report

########### Legal banner
echo "###############################################################################################"> /etc/issue
echo "#                                                                                             #">> /etc/issue
echo "# UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED                                            #">> /etc/issue
echo "#                                                                                             #">> /etc/issue
echo "# You must have explicit, authorized permission to access or configure this device.           #">> /etc/issue
echo "#                                                                                             #">> /etc/issue
echo "# Unauthorized attempts and actions to access or use this system may result in civil and/or   #">> /etc/issue
echo "# criminal penalties.                                                                         #">> /etc/issue
echo "#                                                                                             #">> /etc/issue
echo "# All activities performed on this device are logged and monitored.                           #">> /etc/issue
echo "#                                                                                             #">> /etc/issue
echo "###############################################################################################">> /etc/issue

cp /etc/issue /etc/issue.net

############# Kernel Hardening
cp /etc/sysctl.conf /etc/backup/sysctl.conf.save
