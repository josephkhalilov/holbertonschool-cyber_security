#!/bin/bash
# 3-ips.sh: Uğurlu giriş edən 18 unikal IP-ni tapan skript

LOG_FILE="auth.log"

if [ ! -f "$LOG_FILE" ]; then
    exit 1
fi

# 1. "Accepted password" olan sətirləri seçirik (bu, uğurlu qırılmaları göstərir)
# 2. "from" sözündən dərhal sonra gələn IP ünvanını kəsib götürürük
# 3. Unikal ünvanları sıralayırıq
# 4. Sayırıq
grep "Accepted password" "$LOG_FILE" | awk '{for(i=1;i<=NF;i++) if($i=="from") print $(i+1)}' | sort -u | wc -l
