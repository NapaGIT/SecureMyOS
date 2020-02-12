#!/bin/bash

############ Portsentry
DEBIAN_FRONTEND=noninteractive apt install -yq portsentry
default=/etc/default/portsentry
conf_file=/etc/portsentry/portsentry.conf

old_mode_tcp='TCP_MODE="tcp"'
new_mode_tcp='TCP_MODE="atcp"'
sed -i "s/$old_mode_tcp/$new_mode_tcp/g" $default

old_mode_udp='UDP_MODE="udp"'
new_mode_udp='UDP_MODE="audp"'
sed -i "s/$old_mode_udp/$new_mode_udp/g" $default

