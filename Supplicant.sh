#!/bin/bash
sudo sed -e '1,/    wpa/s/    wpa/#    wpa/' /etc/network/interfaces >> /etc/network/interfaces2
sudo mv /etc/network/interfaces /etc/network/interfaces.orig
sudo mv /etc/network/interfaces2 /etc/network/interfaces

sudo service dhcpcd restart
