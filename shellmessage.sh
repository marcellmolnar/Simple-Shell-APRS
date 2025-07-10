#!/bin/bash
###### shellmessage 1.0 A simple SHELL APRS Messenger by WA1GOV
###### Works with Linux & Windows/Cygwin with netcat package installed
######
if [ -z "$2" ]
then
    echo "Usage: $0 < callsign-ssid > < message >"
    exit
fi

## Change the following variables to select your call, password etc.

. .env

serverHost="rotate.aprs2.net" # See http://www.aprs2.net/APRServe2.txt
serverPort=14580 # Definable Filter Port
address="${callsign}>APRS,TCPIP::"
login="user $callsign pass $password vers shellmessage 1.0"
TOCALL="$1"
comment="$2"

TOCALL=`printf "%-9s" $TOCALL`
packet="${address}${TOCALL}:${comment}"
#netcat-openbsd -C $serverHost $serverPort -q 5 <<END
#$login
#$packet
#END

{
  printf "%s\r\n" "$login"
  printf "%s\r\n" "$packet"
  sleep 5
} | nc $serverHost $serverPort

