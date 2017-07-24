#!/bin/sh

CONFIGFILE="monitor_mode.conf"

while getopts c: option
do
    case "${option}" in
        c)
        CONFIGFILE=${OPTARG};;
    esac
done

CFG=`cat $CONFIGFILE`

while getopts :p:,d:,m:,c: option $CFG $CFG
do
    case "${option}" in
        p)
        PHY="${OPTARG}";;
        d)
        DEV="${OPTARG}";;
        m)
        MON="${OPTARG}";;
        c)
        CHANNEL="${OPTARG}";;
    esac
done

echo "Removing monitor interface $MON:"
sudo iw dev $MON del

echo "Adding managed interface $DEV on physical interface $PHY:"
sudo iw phy $PHY interface add $DEV type managed

echo "Setting $DEV up:"
sudo ifconfig $DEV up

echo "removing config file $CONFIGFILE"
rm $CONFIGFILE
