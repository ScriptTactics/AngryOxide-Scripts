#!/bin/bash

set -e

function yes_or_no {
    while true; do
        read -p "$*Are you using GPSD Forwarder?[y/n]: " yn
        case $yn in
            [Yy]*) GPSD_FORWARDER=true; return ;;
            [Nn]*) GPSD_FORWARDER=false; return ;;
        esac
    done
}

function create_service {
    echo "Creating new wardrive.service at ~/wardrive.service"
    
cat << EOF > ~/wardrive.service
    [Unit]
    Description=AngryOxide Wardrive

    [Service]
    ExecStart=/bin/bash $HOME/wardrive.sh $WLAN_DEVICE $(if [[ "$GPSD_FORWARDER" == "true" ]]; then echo  $GPSD_FORWARDER_SETTINGS; fi)
    StandardOutput=journal
    StandardError=journal
    SyslogIdentifier=Wardrive

    Restart=always
    RestartSec=3

    [Install]
    WantedBy=multi-user.target
EOF
}

sudo apt install gpsd

echo "Enter your wireless device name (default: wlan1):"
read -r WLAN_DEVICE
WLAN_DEVICE="${WLAN_DEVICE:-wlan1}"
GPS_DEVICE=false
GPSD_FORWARDER=false

yes_or_no $forwarder

IP=""
PORT=""

# Add error handling for IP and port
if [ $GPSD_FORWARDER=true ]; then
    read -p "Enter the IP of your GPSD Forwarder Server: " IP
    read -p "Enter the PORT of your GPSD Forwarder Server: " PORT
fi
GPSD_FORWARDER_SETTINGS=$IP:$PORT
create_service

sudo mv ~/wardrive.service /etc/systemd/system/wardrive.service
sudo systemctl daemon-reload
sudo systemctl enable wardrive.service