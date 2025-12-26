#!/bin/bash
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT && echo "Rules updated" && sudo ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT && echo "Rules updated (v6)"
