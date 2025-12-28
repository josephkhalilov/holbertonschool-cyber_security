#!/bin/bash

# Domain adının verilib-verilmədiyini yoxlayırıq
if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1

# WHOIS məlumatını çəkirik və AWK ilə emal edirik
whois "$DOMAIN" | awk -F': +' '
BEGIN {
    # Çıxışda olacaq bölmələr və sahələr
    split("Registrant;Admin;Tech", types, ";")
    split("Name;Organization;Street;City;State/Province;Postal Code;Country;Phone;Phone Ext:;Fax;Fax Ext:;Email", fields, ";")
}
{
    # WHOIS cavabındakı lazımi məlumatları assosiativ massivə yığırıq
    # Məsələn: data["Registrant Name"] = "Holberton Inc"
    if ($1 ~ /^(Registrant|Admin|Tech) /) {
        key = $1
        val = $2
        gsub(/[ \t]+$/, "", val) # Sondakı artıq boşluqları təmizlə
        data[key] = val
    }
}
END {
    output = ""
    for (i = 1; i <= 3; i++) {
        for (j = 1; j <= 12; j++) {
            # Sahə adını düzəldirik
            full_field = types[i] " " fields[j]

            # WHOIS-də axtarış üçün açar (məsələn: "Registrant Phone Ext:" -> "Registrant Phone Ext")
            lookup_key = full_field
            sub(/:$/, "", lookup_key)

            value = data[lookup_key]

            # "Street" sahəsinin sonuna mütləq boşluq əlavə edirik
            if (fields[j] == "Street" && value != "") {
                value = value " "
            }

            # Sətri formalaşdırırıq: "Field,Value"
            output = output full_field "," value "\n"
        }
    }
    # Sonuncu sətirdə yeni sətir (\n) olmasın deyə printf istifadə edirik
    printf "%s", substr(output, 1, length(output) - 1)
}' > "${DOMAIN}.csv"
