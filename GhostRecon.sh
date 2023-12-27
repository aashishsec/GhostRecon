#!/bin/bash

echo "░██████╗░██╗░░██╗░█████╗░░██████╗████████╗██████╗░███████╗░█████╗░░█████╗░███╗░░██╗"
echo "██╔════╝░██║░░██║██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║"
echo "██║░░██╗░███████║██║░░██║╚█████╗░░░░██║░░░██████╔╝█████╗░░██║░░╚═╝██║░░██║██╔██╗██║"
echo "██║░░╚██╗██╔══██║██║░░██║░╚═══██╗░░░██║░░░██╔══██╗██╔══╝░░██║░░██╗██║░░██║██║╚████║"
echo "╚██████╔╝██║░░██║╚█████╔╝██████╔╝░░░██║░░░██║░░██║███████╗╚█████╔╝╚█████╔╝██║░╚███║"
echo "░╚═════╝░╚═╝░░╚═╝░╚════╝░╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░╚════╝░░╚════╝░╚═╝░░╚══╝"
echo "                                                                                      "
echo "                            Author: Aashishsec  "
echo "                             Github: https://github.com/aashishsec/       "

if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain="$1"

# Wayback Machine (web.archive.org)
curl -s "http://web.archive.org/cdx/search/cdx?url=*.${domain}/*&output=text&fl=original&collapse=urlkey" | sed -e 's_https*://__' -e "s/\/.*//" | sort -u | tee web_archive.txt

# crt.sh
curl "https://crt.sh/?q=${domain}" | grep -F ".${domain}" | sort -u | cut -d'>' -f2 | cut -d'<' -f1 | sort -u | tee crt.txt

# UrlScan.io - Uncomment this line if needed
#curl -s "https://urlscan.io/api/v1/search/?q=${domain}" | jq '.data | .[].attributes | .url' | sed 's/\"//g' | sort -u | tee urlscan.txt

# AlienVault - Uncomment this line if needed
#curl -s "https://otx.alienvault.com/api/v1/indicators/domain/${domain}/passive_dns" | jq '.passive_dns[].hostname' | sed 's/\"//g' | sort -u | tee alienvault.txt

# Security Trails
curl -s --request GET --url "https://api.securitytrails.com/v1/domain/${domain}/subdomains" --header "APIKEY: YOUR_SECURITYTRAILS_API_KEY" | jq '.subdomains[]' | sed 's/\"//g' > "${domain}_securitytrails.txt"

echo "Reconnaissance completed successfully."
