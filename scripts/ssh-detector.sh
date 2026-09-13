#!/bin/bash

THRESHOLD=3
TIME_WINDOW="-30 min"
NOW=$(date)

echo "========================================"
echo "       SSH FAILED LOGIN DETECTOR"
echo "========================================"
echo "Time:       $NOW"
echo "Window:     Last 30 minutes"
echo "Threshold:  $THRESHOLD failed attempts"
echo

ALERTS=$(sudo journalctl -u ssh --since "$TIME_WINDOW" --no-pager |
grep "Failed password" |
awk '{for(i=1;i<=NF;i++) if($i=="from") print $(i+1)}' |
sort |
uniq -c |
awk -v threshold="$THRESHOLD" '$1 >= threshold {print $2, $1}')

if [ -z "$ALERTS" ]; then
    echo "STATUS: NO ALERTS"
    echo "No SSH sources exceeded the failed-login threshold."
else
    echo "STATUS: ALERT"
    echo

    while read IP COUNT; do
        echo "Source IP:      $IP"
        echo "Failed Logins:  $COUNT"
        echo "Threshold:      $THRESHOLD"
        echo "Assessment:     Possible SSH brute-force activity"
        echo
    done <<< "$ALERTS"
fi

echo "========================================"
