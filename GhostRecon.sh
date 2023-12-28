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
echo "Fetching subdomains from the Wayback Machine..."
curl -s "http://web.archive.org/cdx/search/cdx?url=*.${domain}/*&output=text&fl=original&collapse=urlkey" | sed -e 's_https*://__' -e "s/\/.*//" | sort -u > web_archive.txt
echo "Wayback Machine subdomains saved to web_archive.txt."

# crt.sh
echo "Fetching subdomains from crt.sh..."
curl "https://crt.sh/?q=${domain}" | grep -F ".${domain}" | sort -u | cut -d'>' -f2 | cut -d'<' -f1 > crt.txt
echo "crt.sh subdomains saved to crt.txt."

# UrlScan.io
echo "Fetching subdomains from UrlScan.io..."
# curl -s "https://urlscan.io/api/v1/search/?q=${domain}" | jq '.data | .[].attributes | .url' | sed 's/\"//g' | sort -u > urlscan.txt
echo "UrlScan.io subdomains saved to urlscan.txt."

# AlienVault
echo "Fetching subdomains from AlienVault..."
# curl -s "https://otx.alienvault.com/api/v1/indicators/domain/${domain}/passive_dns" | jq '.passive_dns[].hostname' | sed 's/\"//g' | sort -u > alienvault.txt
echo "AlienVault subdomains saved to alienvault.txt."

# Security Trails
echo "Fetching subdomains from Security Trails..."
curl -s --request GET --url "https://api.securitytrails.com/v1/domain/${domain}/subdomains" --header "APIKEY: YOUR_SECURITYTRAILS_API_KEY" | jq '.subdomains[]' | sed 's/\"//g' | sort -u > "${domain}_securitytrails.txt"
echo "Security Trails subdomains saved to ${domain}_securitytrails.txt."

# Shrewdeye
echo "Downloading subdomains from Shrewdeye..."
curl -O "https://shrewdeye.app/domains/${domain}.txt"
echo "Shrewdeye subdomains saved to ${domain}.txt."

# Concatenate and filter unique domains
echo "Concatenate and filter unique domains..."
cat web_archive.txt crt.txt urlscan.txt alienvault.txt "${domain}_securitytrails.txt" "${domain}.txt" | sort -u > all_domains.txt
echo "Reconnaissance completed successfully. Unique domains saved to all_domains.txt."
