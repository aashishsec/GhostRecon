#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain="$1"

#web.archive.org 

curl -s "http://web.archive.org/cdx/search/cdx?url=*.${domain}/*&output=text&fl=original&collapse=urlkey" | sed -e 's_https*://__' -e "s/\/.*//" | sort -u | tee web_archive.txt

#crt.sh 

curl "https://crt.sh/?q=${domain}" | grep -F ".${domain}" | sort -u | cut -d'>' -f2 | cut -d'<' -f1 | sort -u | tee crt.txt

#UrlScan.io

#AlienVault


