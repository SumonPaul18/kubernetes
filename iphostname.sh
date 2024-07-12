#!/bin/bash
# Assign IP Addresses ASK using Shell Script
bgreen='\033[1;32m'
red='\033[0;31m'
nc='\033[0m'
bold="\033[1m"
blink="\033[5m"
echo
echo
echo -e "${bgreen}Assign IP Addresses and Hostname,TimeZone Asking using Shell Script ${nc} "
hostnamectl
timedatectl
timedatectl set-timezone Asia/Dhaka
timedatectl
echo
read -p "$(echo -e "${bgreen}${bold}${blink}Type System Hostname: ${nc}")" hostname
hostnamectl set-hostname $hostname
exec bash

# Creates a backup
cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak_`date +%Y%m%d%H%M`
ip a
read -p "Type static IP Interface Name: " STATIC_INTERFACE
read -p "Type DHCP Interface Name: " DHCP_INTERFACE
read -p "Type static IP Address with CIDR: " IP_ADDRESS
read -p "Type Gateway4: " GATEWAY
read -p "Type DNS: " DNS

cat <<EOF | sudo tee /etc/netplan/00-installer-config.yaml
network:
  renderer: networkd
  ethernets:
    $STATIC_INTERFACE:
      dhcp4: no
      addresses:
        - $IP_ADDRESS
      routes: 
        - to: default
          via: $GATEWAY
      nameservers:
        addresses: [$DNS]
    $DHCP_INTERFACE:
      dhcp4: yes
EOF
sudo netplan apply
ip a
