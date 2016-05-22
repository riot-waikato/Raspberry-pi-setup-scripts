#!/bin/bash

echo "Setting up ipv4 forwarding..."

sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
echo "iptables-restore < /etc/iptables.ipv4.nat" >> /lib/dhcpcd/dhcpcd-hooks/70-ipv4-nat
