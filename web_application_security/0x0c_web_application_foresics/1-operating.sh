#!/bin/bash
# Check if the dmesg log file exists in the current directory
LOG_FILE="dmesg"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: $LOG_FILE not found."
    exit 1
fi

# Search for the line containing "Linux version" and print it
grep "Linux version" "$LOG_FILE"
