#!/bin/bash
# Script to identify the number of unique IP addresses with successful logins

LOG_FILE="auth.log"

if [ ! -f "$LOG_FILE" ]; then
    exit 1
fi

# 1. Filter for successful logins
# 2. Extract the string immediately following the word 'from'
# 3. Sort and unique to get the distinct list
# 4. Count the lines
grep "Accepted" "$LOG_FILE" | awk '{ for(i=1;i<=NF;i++) if($i=="from") print $(i+1) }' | sort -u | wc -l
