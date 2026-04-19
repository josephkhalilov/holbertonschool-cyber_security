#!/bin/bash
# Define the log file
LOG_FILE="auth.log"

if [ ! -f "$LOG_FILE" ]; then
    exit 1
fi

# 1. Take the last 1000 lines
# 2. Find lines where a password was "Accepted"
# 3. Extract the username (typically the 9th field in auth.log)
# 4. Check if that same user has "Failed password" entries in the same 1000 lines

tail -n 1000 "$LOG_FILE" | grep "Accepted password" | awk '{print $9}' | sort -u | while read -r user; do
    if tail -n 1000 "$LOG_FILE" | grep -q "Failed password for $user"; then
        echo "$user"
    fi
done
