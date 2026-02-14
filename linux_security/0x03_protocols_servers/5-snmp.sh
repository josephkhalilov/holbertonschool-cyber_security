#!/bin/bash
grep -E "public|rocommunity|rwcommunity" /etc/snmp/snmpd.conf | grep -v "^#"
