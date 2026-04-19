#!/bin/bash
awk -F'[=,]' '/useradd.*name=/ {users[$2]} 
END {
    for (u in users) printf (i++ ? "," : "") u; 
    print ""
}' auth.log | tr ',' '\n' | sort | tr '\n' ',' | sed 's/,$/\n/'
