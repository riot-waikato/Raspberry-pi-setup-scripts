#!/bin/bash
#SCRIPT FOR SETTING UP RIOT RASPIS
#Written by Nathan Bryan Kelly

##########################################################
#                                                        #
#                   Set up parameters                    #
#                                                        #
##########################################################
SSID="riot-waikato-"$1
WPA_KEY=$2
IP_PREFIX="172.24."
IP_SUFFIX=".1/24"
IP_MIN=".50"
IP_MAX=".150"
LEASE_TIME="12h"
IP_NUM=$3
isnumber="^[0-9]+$"
USAGE="usage: [SSID ID] [WPA KEY] [IP NUMBER]"
PATTERN_INTERFACES="wpa-conf"
IP_ADDR=$IP_PREFIX$IP_NUM$IP_SUFFIX


##########################################################
#                                                        #
#              Sanity check our parameters               #
#                                                        #
##########################################################

if [[ -z "$1" || -z "$2" || -z "$3" ]] ; then
    echo $USAGE
    exit
fi

echo "ID: "$SSID
echo "WPA_KEY: "$WPA_KEY
echo ""

if [[ ${#WPA_KEY} > 7 && ${#WPA_KEY} < 64 ]] ; then
    echo "WPA key must be between 8 and 64 characters."
    echo $USAGE
    exit
fi

if ! [[ $IP_NUM =~ ^-?[0-9]+$ ]]; then
    echo "ipnum (ARG3: $IP_NUM) is not a number!"
    echo $USAGE
    exit
fi

if [ "$IP_NUM" -ge 255 -o "$IP_NUM" -le 0 ] ; then
   echo "ipnum (ARG3: $IP_NUM) is out of range (1-254)"
   echo $usage
   exit
fi



echo "This device will be configured as "$IP_ADDR
echo ""

if ! [[ -z "$4" ]] ; then
    echo "Test-mode: no changes will be applied"
    echo ""
    echo "Configuring dhcpcd.conf..."
    echo "Configuring hostapd..."
    echo "Setting up dnsmasq..."
    echo "Setting up ipv4 forwarding..."
    echo "Starting services..."
    echo ""
    echo ""
    echo "You may want to restart now..."
    exit
fi

#test zone

##########################################################
#                                                        #
#          Run each component script in order            #
#                                                        #
##########################################################

#set dhcpcd configuration
sudo /bin/bash Dhcpcd.sh $IP_ADDR
#set wpa_supplicant to not interfere
sudo /bin/bash Supplicant.sh
#configure hostpad configuration
sudo /bin/bash Hostapd.sh $SSID $WPA_KEY
#configure dnsmasquerade settings for dhcp
sudo /bin/bash Dnsmasq.sh $IP_PREFIX $IP_NUM $IP_MIN $IP_MAX $LEASE_TIME
#configure ipv4 forwarding via wlan0 -> eth0
sudo /bin/bash Ipforward.sh

#finishing up

echo "Starting services..."

sudo service hostapd start
sudo service dnsmasq start

echo ""
echo ""
echo "You may want to restart now..."
