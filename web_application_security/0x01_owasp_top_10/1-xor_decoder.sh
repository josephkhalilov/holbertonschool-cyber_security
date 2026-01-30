#!/bin/bash
# Script that decodes XOR WebSphere encoded strings
# Usage: ./1-xor_decoder.sh {xor}encoded_string

hash="${1#{xor\}}"

decoded=$(echo "$hash" | base64 -d | od -An -tu1)

for dec in $decoded
do
    xored=$((dec ^ 95))
    printf "\\$(printf '%03o' "$xored")"
done

echo
