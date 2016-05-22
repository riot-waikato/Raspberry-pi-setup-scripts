#!/bin/bash

IP_PREFIX=$1
IP_NUM=$2
IP_MIN=$3
IP_MAX=$4
LEASE_TIME=$5

echo "Setting up dnsmasq..."

sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig

sudo echo "interface=wlan0" >> /etc/dnsmasq.conf
sudo echo "bind-interfaces" >> /etc/dnsmasq.conf
sudo echo "server=8.8.8.8" >> /etc/dnsmasq.conf
sudo echo "domain-needed" >> /etc/dnsmasq.conf
sudo echo "bogus-priv" >> /etc/dnsmasq.conf
sudo echo "dhcp-range="$IP_PREFIX$IP_NUM$IP_MIN","$IP_PREFIX$IP_NUM$IP_MAX","$LEASE_TIME >> /etc/dnsmasq.conf
