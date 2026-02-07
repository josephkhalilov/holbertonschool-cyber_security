#!/bin/bash
# A script that hashes a password using SHA-1 and saves it to a file

# Echo the first argument ($1) without a trailing newline
# Pipe it into sha1sum to generate the hash
# Use awk to print only the hash (removing the trailing "  -")
# Redirect the output to 0_hash.txt
echo -n "$1" | sha1sum | awk '{print $1}' > 0_hash.txt
