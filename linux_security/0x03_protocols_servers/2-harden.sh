#!/bin/bash
find / -type d -perm -0002 -ls | awk '{print $11}'
find / -type d -perm -0002 -exec chmod o-w {} +
