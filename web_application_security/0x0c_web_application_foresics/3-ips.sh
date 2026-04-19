#!/bin/bash
# Analysis script to extract unique successful login IPs

LOG_FILE="auth.log"

if [ ! -f "$LOG_FILE" ]; then
    exit 1
fi

# We use grep to find successful entries
# Then use awk to find the word 'from' and print the word immediately following it
# This is more robust than using a fixed column number ($11)
grep "Accepted" "$LOG_FILE" | awk '{ for(i=1;i<=NF;i++) if($i=="from") print $(i+1) }' | sort -u | wc -l
