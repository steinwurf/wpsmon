#!/bin/sh

MON=$1
CHANNEL=$2


echo "Setting interface $MON to channel $CHANNEL"
sudo iw dev $MON set channel $CHANNEL
