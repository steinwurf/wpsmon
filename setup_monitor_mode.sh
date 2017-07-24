#!/bin/sh

PHY="phy0"
DEV="wlan0"
MON="mon0"
CHANNEL="36"

while getopts hp:d:m:c: option
do
    case "${option}" in
        h)
        echo "Usage:"
        echo "$0 -p <phy|phy0> -d <device|wlan0> -m <mon|mon0> -c <channel|36>"
        exit ;;
        p)
        PHY=${OPTARG};;
        d)
        DEV=${OPTARG};;
        m)
        MON=${OPTARG};;
        c)
        CHANNEL=${OPTARG};;
    esac
done

echo "Setting physical device $PHY into monitor mode on interface $MON"
sudo iw phy $PHY interface add $MON type monitor

echo "Removing interface $WLAN"
sudo iw dev $DEV del

echo "Setting interface $MON up"
sudo ifconfig $MON up

echo "Setting interface $MON channel to $CHANNEL"
sudo iw dev $MON set channel $CHANNEL

echo "Saving config in monitor_mode.conf"
echo "-p $PHY -d $DEV -m $MON -c $CHANNEL" > monitor_mode.conf

echo "Revert settings with:"
echo "$ revert_monitor_mode.sh -c monitor_mode.conf"
