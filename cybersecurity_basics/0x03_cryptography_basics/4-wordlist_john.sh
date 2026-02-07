#!/bin/bash
john --wordlist=/usr/share/wordlists/rockyou.txt "$1" > /dev/null 2>&1 john --show "$1" | awk -F: 'NR>1 {print $2}' | head -n -2 > 4-password.txt
