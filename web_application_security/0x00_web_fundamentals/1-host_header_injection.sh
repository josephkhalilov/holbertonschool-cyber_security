#!/bin/bash
curl -s -X POST "$2" -H "Host: $1" --data "$3"
