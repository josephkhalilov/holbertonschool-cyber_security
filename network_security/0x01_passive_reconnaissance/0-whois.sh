#!/bin/bash
whois "$1" | awk -F': ' '/^(Registrant|Admin|Tech)/ && !/ID:/ {gsub(/^[ \t]+|[ \t]+$/, "", $2); if($1 ~ /Ext:$/) print $1", "; else if($1 ~ /Street$/) print $1", "$2; else print $1", "$2}' > "${1}.csv"
