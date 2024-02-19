#!/bin/bash

set -e

WLAN_DEVICE=$1
GPS_FORWARDER_SETTINGS=$2

if [ -z $GPS_FORWARDER_SETTINGS ]; then
    angryoxide -i $WLAN_DEVICE --notransmit --headless --autoexit
else
    angryoxide -i $WLAN_DEVICE --notransmit --headless --autoexit --gpsd $GPS_FORWARDER_SETTINGS

fi

