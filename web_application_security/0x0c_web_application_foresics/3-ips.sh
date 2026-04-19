#!/bin/bash
# Check for the existence of the log file
LOG_FILE="auth.log"

if [ ! -f "$LOG_FILE" ]; then
    exit 1
fi

# 1. Filter for all successful login entries ("Accepted")
# 2. Use awk to extract the 11th field (the IP address)
# 3. Sort the IPs and keep only unique entries
# 4. Count the total number of unique IPs
grep "Accepted" "$LOG_FILE" | awk '{print $11}' | sort -u | wc -l
