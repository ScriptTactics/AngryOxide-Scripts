#!/bin/bash

set -e

WLAN_DEVICE=$1
GPS_FORWARDER_SETTINGS=$2

pkill gpsd
gpsd -n /dev/ttyACM0
sleep 1

UTCDATE=`gpspipe -w | grep -m 1 "TPV" | sed -r 's/.*"time":"([^"]*)".*/\1/' | sed -e 's/^\(.\{10\}\)T\(.\{8\}\).*/\1 \2/'`
date -u -s "$UTCDATE"

if [ -z $GPS_FORWARDER_SETTINGS ]; then
    angryoxide -i $WLAN_DEVICE --notransmit --headless --autoexit
else
    angryoxide -i $WLAN_DEVICE --notransmit --headless --autoexit --gpsd $GPS_FORWARDER_SETTINGS

fi

