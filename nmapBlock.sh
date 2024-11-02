#!/bin/sh

# Define log file and temp file
LOGFILE="/var/log/pflog"
TEMPFILE="/tmp/nmap_detected_ips.txt"

# Clear the temp file
> $TEMPFILE

# Analyze the log for SYN packets to multiple ports
tcpdump -n -r $LOGFILE 'tcp[tcpflags] & (tcp-syn) != 0' | awk '{print $3}' | sort | uniq -c | awk '$1 > 5 {print $2}' > $TEMPFILE

# Loop through detected IPs and block them
while read -r IP; do
    # Check if IP is already blocked
    if ! pfctl -sr | grep -q "$IP"; then
        echo "Blocking IP: $IP"
        # Block the IP
        pfctl -t blocklist -T add $IP
    fi
done < $TEMPFILE

# Clean up temp file
rm -f $TEMPFILE
