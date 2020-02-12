#!/bin/bash

########### Lynis scan

wget -O - https://packages.cisofy.com/keys/cisofy-software-public.key | sudo apt-key add -
apt install apt-transport-https
echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/99disable-translations
echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" > /etc/apt/sources.list.d/cisofy-lynis.list
apt update
apt-get install -y lynis

lynis audit system
cp /var/log/lynis.log /var/log/report/lynis.log

lynis_log="/var/log/lynis.log"
sysctl_file="/etc/sysctl.conf"

old_fs_suid_dumpable=$(cat $sysctl_file | grep "fs.suid_dumpable" | awk -F '=' '{print $2}')

change_fs_suid_dumpable() {
check_fs_suid_dumpable=$(cat $lynis_log | grep "fs.suid_dumpable" | grep "equal")
if [[ -z $check_fs_suid_dumpable ]]
then

        new_fs_suid_dumpable=$(cat $lynis_log | grep -i "fs.suid_dumpable" | grep "Result:" | awk -F '=' '{print $2}')
        sed -i "s/$old_fs_suid_dumpable/$new_fs_suid_dumpable/g" $sysctl_file
fi
}

case $old_fs_suid_dumpable in
        "")
                echo "fs.suid_dumpable=${new_fs_suid_dumpable}" >> $sysctl_file
                ;;
        *)
                change_fs_suid_dumpable
                ;;
esac

old_kernel_core_uses_pid=$(cat $sysctl_file | grep "kernel.core_uses_pid" | awk -F '=' '{print $2}')

change_kernel_core_uses_pid() {
check_kernel_core_uses_pid=$(cat $lynis_log | grep "kernel.core_uses_pid" | grep "equal")
if [[ -z $check_kernel_core_uses_pid ]]
then

        new_kernel_core_uses_pid=$(cat $lynis_log | grep -i "kernel.core_uses_pid" | grep "Result:" | awk -F '=' '{print $2}')
        sed -i "s/$old_kernel_core_uses_pid/$new_kernel_core_uses_pid/g" $sysctl_file
fi
}

case $old_kernel_core_uses_pid in
        "")
                echo "kernel.core_uses_pid=${new_kernel_core_uses_pid}" >> $sysctl_file
                ;;
        *)
                change_kernel_core_uses_pid
                ;;
esac

sysctl -p

