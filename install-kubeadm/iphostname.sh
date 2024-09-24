#!/bin/bash
# Assign IP Addresses ASK using Shell Script
bgreen='\033[1;32m'
red='\033[0;31m'
nc='\033[0m'
bold="\033[1m"
blink="\033[5m"
echo
echo
echo -e "${bgreen}Setup Static IP, Hostname, TimeZone, FQDN ${nc} "
hostnamectl
timedatectl
timedatectl set-timezone Asia/Dhaka
timedatectl
echo
read -p "$(echo -e "${bgreen}${bold}${blink}Type System Hostname: ${nc}")" hostname
read -p "$(echo -e "${bgreen}${bold}${blink}Type Domain Name [Paulco.xyz]: ${nc}")" domain_name
hostnamectl set-hostname $hostname
hostname -f
# Copy orginal file as a backup
cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak_`date +%Y%m%d%H%M`
ip a
read -p "Type static IP Interface Name: " STATIC_INTERFACE
#read -p "Type DHCP Interface Name: " DHCP_INTERFACE
read -p "Type Only IP Address [192.168.0.2]: " ipaddr
read -p "Type IP Address with CIDR [192.168.0.2/24]: " IP_ADDRESS
read -p "Type Gateway4[192.168.0.1]: " GATEWAY
read -p "Type DNS[8.8.8.8]: " DNS
#ipaddr=$(/sbin/ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}') 
echo "$ipaddr $hostname.$domain_name $hostname" >> /etc/hosts
hostname -f
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
    #$DHCP_INTERFACE:
      #dhcp4: yes
EOF
cat /etc/netplan/00-installer-config.yaml
sudo netplan apply
ip a
