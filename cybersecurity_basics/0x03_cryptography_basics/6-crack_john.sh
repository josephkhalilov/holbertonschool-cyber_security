#!/bin/bash
john --format=Raw-SHA256 "$1"
john --show --format=Raw-SHA256 "$1" | head -n 1 | cut -d: -f2 > 6-password.txt
