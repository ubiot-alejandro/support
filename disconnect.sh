# Disconnection to the VPN
echo Disconnecting to the VPN...
echo
uci set wireguard.@proxy[0].enable='0'
uci commit wireguard
/etc/init.d/wireguard restart
