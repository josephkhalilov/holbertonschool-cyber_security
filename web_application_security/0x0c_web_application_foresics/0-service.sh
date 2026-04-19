#!/bin/bash
LOG_FILE="auth.log"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: $LOG_FILE not found."
    exit 1
fi
awk '{print $5}' "$LOG_FILE" | sort | uniq -c | sort -rn
