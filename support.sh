#!/bin/bash

# Variables
id=0001
end=1
str=$(wg)

# Init for loop ("end" can be changed to excecute it more times)
for ((i=1;i<=end;i++));

do
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

done