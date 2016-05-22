#!/bin/bash
IP_ADDR=$1

echo ""
echo "configuring dhcpcd.conf..."

echo "" >> /etc/dhcpcd.conf
echo "interface wlan0" >> /etc/dhcpcd.conf
echo "    static ip_address="$IP_ADDR >>/etc/dhcpcd.conf
