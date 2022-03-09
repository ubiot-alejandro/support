#!/bin/bash

# Variables
id=0000
str=$(wg)

# Checking if reboot required
if [ $(curl -s https://raw.githubusercontent.com/ubiot-alejandro/support/main/tei.txt | grep $id | cut -d "=" -f3) == "R" ]; then
    # Reading days uptime
    d=$(uptime | awk -F'( |,|:)+' '{d=h=m=0; if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}' | cut -d "," -f1 | cut -d " " -f1)
    if [ $d -gt 0 ]; then
        echo Rebooting by days
        reboot
    else 
        # Reading hours uptime
        h=$(uptime | awk -F'( |,|:)+' '{d=h=m=0; if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}' | cut -d "," -f2 | cut -d " " -f2)
        if [ $h -gt 0 ]; then
            echo Rebooting by hours
            reboot
        else
            # Reading minutes uptime
            m=$(uptime | awk -F'( |,|:)+' '{d=h=m=0; if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}' | cut -d "," -f3 | cut -d " " -f2)
            if [ $m -gt 15 ]; then
                echo Rebooting by minutes
                reboot
            else
                Not rebooting, waiting...
            fi
        fi
    fi
fi

# Reading the GitHub file to know if is needed to connect/disconnect to the VPN
if [ $(curl -s https://raw.githubusercontent.com/ubiot-alejandro/support/main/tei.txt | grep $id | cut -d "=" -f2) -eq 01 ]; then
    str=$(wg)
    # If the VPN is connected, don't connect again
    if [ $( echo ${#str}) -ne 0 ]; then 
        # Connection to the VPN
        echo Connecting to the VPN...
        echo 
        uci set wireguard.@proxy[0].enable='1'
        uci commit wireguard
        /etc/init.d/wireguard restart
        sleep 30
        str=$(wg)
    fi
    echo VPN connected...
    echo 
else

    str=$(wg)
    # If the VPN is disconnected, don't disconnet again
    if [ $(echo ${#str}) -ne 0 ]; then
        # Disconnection to the VPN
        echo Disconnecting to the VPN...
        echo
        uci set wireguard.@proxy[0].enable='0'
        uci commit wireguard
        /etc/init.d/wireguard restart
        sleep 30
        str=$(wg)
    fi
    echo VPN disconnected...
    echo
fi;
