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
hostname -f
# Creates a backup
cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak_`date +%Y%m%d%H%M`
ip a
read -p "Type static IP Interface Name: " STATIC_INTERFACE
read -p "Type DHCP Interface Name: " DHCP_INTERFACE
read -p "Type Only IP Address: " ipaddr
read -p "Type static IP Address with CIDR: " IP_ADDRESS
read -p "Type Gateway4: " GATEWAY
read -p "Type DNS: " DNS
#ipaddr=$(/sbin/ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}') 
echo "$ipaddr $hostname.paulco.xyz $hostname" >> /etc/hosts
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
    $DHCP_INTERFACE:
      dhcp4: yes
EOF
sudo netplan apply
ip a

#Install Kubernetes Using Kubeadm on Ubuntu 22.04.xx

sudo apt update -y && sudo apt upgrade -y
read -p "$(echo -e "${bgreen}${bold}${blink}Type Worker Hostname: ${nc}")" worker-hostname
read -p "$(echo -e "${bgreen}${bold}${blink}Type Worker IP Address: ${nc}")" worker-ipaddr
echo "$worker-ipaddr $worker-hostname.paulco.xyz $worker-hostname" >> /etc/hosts

sudo swapoff –a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system

sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
docker --version
sudo usermod -aG docker ${USER}
su - ${USER}
sudo systemctl enable docker
systemctl is-active --quiet docker && echo Docker is running
sudo usermod -aG docker $USER

sudo systemctl start docker

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

systemctl daemon-reload
systemctl start kubelet
systemctl enable kubelet.service

kubeadm version


