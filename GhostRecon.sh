#!/bin/bash

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

echo -e "                                                                                      "
echo -e "                                                                                      "
echo -e "${RED}░██████╗░██╗░░██╗░█████╗░░██████╗████████╗██████╗░███████╗░█████╗░░█████╗░███╗░░██╗${RESET}"
echo -e "${RED}██╔════╝░██║░░██║██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║${RESET}"
echo -e "${RED}██║░░██╗░███████║██║░░██║╚█████╗░░░░██║░░░██████╔╝█████╗░░██║░░╚═╝██║░░██║██╔██╗██║${RESET}"
echo -e "${RED}██║░░╚██╗██╔══██║██║░░██║░╚═══██╗░░░██║░░░██╔══██╗██╔══╝░░██║░░██╗██║░░██║██║╚████║${RESET}"
echo -e "${RED}╚██████╔╝██║░░██║╚█████╔╝██████╔╝░░░██║░░░██║░░██║███████╗╚█████╔╝╚█████╔╝██║░╚███║${RESET}"
echo -e "${RED}░╚═════╝░╚═╝░░╚═╝░╚════╝░╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░╚════╝░░╚════╝░╚═╝░░╚══╝${RESET}"
echo -e "                                                                                      "
echo -e "                             ${YELLOW}Author: Aashishsec${RESET}  "
echo -e "                             ${YELLOW}Github: https://github.com/aashishsec/${RESET}"
echo -e "                                                                                      "

if [ -z "$1" ]; then
    echo -e "${RED}Usage: $0 <domain>${RESET}"
    exit 1
fi

domain="$1"
output_dir="passive_recon"

echo -e "${YELLOW}We are Enumerating this domain: ${domain}.${RESET}"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Wayback Machine (web.archive.org)
echo -e "${YELLOW}Fetching subdomains from the Wayback Machine...${RESET}"
curl -s "http://web.archive.org/cdx/search/cdx?url=*.${domain}/*&output=text&fl=original&collapse=urlkey" | sed -e 's_https*://__' -e "s/\/.*//" | sort -u > "$output_dir/web_archive.txt"
echo -e "${GREEN}Wayback Machine subdomains saved to $output_dir/web_archive.txt.${RESET}"

echo -e "                                                                                      "
echo -e "                                                                                      "

# crt.sh
echo -e "${YELLOW}Fetching subdomains from crt.sh...${RESET}"
curl "https://crt.sh/?q=${domain}" | grep -F ".${domain}" | sort -u | cut -d'>' -f2 | cut -d'<' -f1 > "$output_dir/crt.txt"
echo -e "${GREEN}crt.sh subdomains saved to $output_dir/crt.txt.${RESET}"

echo -e "                                                                                      "
echo -e "                                                                                      "

# UrlScan.io
echo -e "${YELLOW}Fetching subdomains from UrlScan.io...${RESET}"
curl -s "https://urlscan.io/api/v1/search/?q=${domain}" | jq -r '.results[].task.domain' | sed 's/"//g' | sort -u > "$output_dir/urlscan.txt"
echo -e "${GREEN}UrlScan.io subdomains saved to $output_dir/urlscan.txt.${RESET}"

echo -e "                                                                                      "
echo -e "                                                                                      "

# AlienVault
echo -e "${YELLOW}Fetching subdomains from AlienVault...${RESET}"
curl -s "https://otx.alienvault.com/api/v1/indicators/domain/${domain}/passive_dns" | jq '.passive_dns[].hostname' | sed 's/\"//g' | sort -u > "$output_dir/alienvault.txt"
echo -e "${GREEN}AlienVault subdomains saved to $output_dir/alienvault.txt.${RESET}"

echo -e "                                                                                      "
echo -e "                                                                                      "

# Security Trails
echo -e "${YELLOW}Fetching subdomains from Security Trails...${RESET}"
curl -s --request GET --url "https://api.securitytrails.com/v1/domain/${domain}/subdomains" --header "APIKEY: YOUR_SECURITYTRAILS_API_KEY" | jq '.subdomains[]' | sed 's/\"//g' | sort -u > "$output_dir/${domain}_securitytrails.txt"
echo -e "${GREEN}Security Trails subdomains saved to $output_dir/${domain}_securitytrails.txt.${RESET}"

echo -e "                                                                                      "
echo -e "                                                                                      "

# Shrewdeye
echo -e "${YELLOW}Downloading subdomains from Shrewdeye...${RESET}"
curl -O "https://shrewdeye.app/domains/${domain}.txt"
echo -e "${GREEN}Shrewdeye subdomains saved to ${domain}.txt.${RESET}"

echo -e "                                                                                      "
echo -e "                                                                                      "

# Concatenate and filter unique domains
echo -e "${YELLOW}Concatenate and filter unique domains...${RESET}"
cat "$output_dir/web_archive.txt" "$output_dir/crt.txt" "$output_dir/urlscan.txt" "$output_dir/alienvault.txt" "$output_dir/${domain}_securitytrails.txt" "${domain}.txt" | sort -u > "all_domains.txt"
echo -e "${GREEN}Passive Reconnaissance completed successfully. Unique domains saved to all_domains.txt.${RESET}"

echo -e "                                                                                      "
echo -e "                                                                                      "
echo -e "${GREEN}Number of Subdomains for ${domain} is $(cat all_domains.txt | wc -l).${RESET}"

