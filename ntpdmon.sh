#!/bin/bash

STATUS=$(ntpctl -s status)

echo -e "# HELP ntp_synced If 0 then unsynced, if 1 then synced, if 2 - undefined.\n# TYPE ntp_synced gauge"
if [[ $(echo $STATUS | awk '{{ print $5 }}'| tr -d \,) -eq "unsynced" ]]; then
 echo "ntp_synced 0"
elif [[ $STATUS -eq "synced" ]]; then
 echo "ntp_synced 1"
else
 echo "ntp_synced 2"
fi

VALID_PEERS=$(echo $STATUS | tr '/' ' ' | awk '{{ print $1 }}')
ALL_PEERS=$(echo $STATUS | tr '/' ' ' | awk '{{ print $2 }}')
echo -e "# HELP ntp_peers Number of valid peers, invalid peers and all peers\n# TYPE ntp_peers gauge"
echo -e 'ntp_peers{type="valid"}' "$VALID_PEERS"
echo -e 'ntp_peers{type="invalid"}' "$((ALL_PEERS-VALID_PEERS))"
echo -e 'ntp_peers{type="all"}' "$ALL_PEERS"

echo -e "# HELP ntp_status_offset Offset status from ntpctl -s status\n# TYPE ntp_status_offset gauge"
STATUS_OFFSET=$(echo $STATUS | awk '{{print $9}}' | tr -d 'ms')
if  [[ -z $STATUS_OFFSET ]]; then
 echo -e "ntp_status_offset 0"
else
 echo -e "ntp_status_offset $STATUS_OFFSET"
fi
