#!/bin/bash
#actually installing all of these on an sd card will take ~1-2 hours. Prepare to waste time.
echo "sudo apt-get update"
sudo apt-get update
echo "yes | sudo apt-get install emacs dnsmasq hostapd network-manager"
yes | sudo apt-get install emacs dnsmasq hostapd network-manager

NUMBER=$1
USAGE="usage: [NUMBER]"
WPA_KEY="riotwaikato"

printf -v SSIDNUM "%03d" $NUMBER

#echo $SSIDNUM

if [[ -z "$1" ]] ; then
    echo $USAGE
    exit
fi

if ! [[ $NUMBER =~ ^-?[0-9]+$ ]] ; then
    echo "Error: you entered - $1"
    echo "       This is not a number between 1 and 254"
    echo "       "$USAGE
    exit
fi

if [ "$NUMBER" -ge 255 -o "$NUMBER" -le 0 ] ; then
    echo "Error: you entered - $1"
    echo "       This is not a number between 1 and 254"
    echo "       "$USAGE
    exit
fi

if ! [[ -z "$2" ]] ; then
    sudo /bin/bash Setup.sh $SSIDNUM"A" $WPA_KEY $NUMBER "TM"
else
    sudo /bin/bash Setup.sh $SSIDNUM"A" $WPA_KEY $NUMBER
fi
