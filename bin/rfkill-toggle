#!/bin/sh

# Usage ./rfkill-toggle.sh [IDENTIFIER]
# where IDENTIFIER is the index no. of an rfkill switch or one of:
#   wifi wlan bluetooth uwb ultrawideband wimax wwan gps fm nfc

ID=`rfkill list "$1" | head -c 1 | cut -f 1`
SOFT="/sys/class/rfkill/rfkill$ID/soft"

if [ ! -f "$SOFT" ]; then
    echo "no such identifier"
    exit 1
fi

ACTION="block"
if [ $(cat "$SOFT") -eq 1 ]; then
    ACTION="unblock"
fi

rfkill "$ACTION" "$ID"
