#!/bin/bash
ps aux | grep "^$1 " u | grep -v ' 0  *0 '
