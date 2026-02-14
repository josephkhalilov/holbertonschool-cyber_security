#!/bin/bash
iptables -P INPUT DROP
iptables -A INPUT -p tcp --dport ssh -j ACCEPT; iptables -A INPUT -i lo -j DROP
