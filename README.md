# GhostRecon  - Passive Subdomain Enumeration Tool

# Reconnaissance Tool

![Banner](banner.png)

Author: Aashishsec  
GitHub: [https://github.com/aashishsec/](https://github.com/aashishsec/)

## Overview

This Bash script is a reconnaissance tool designed to gather subdomains of a specified domain from various sources. It currently supports the following data sources:

- [Wayback Machine (web.archive.org)](http://web.archive.org/)
- [crt.sh](https://crt.sh/)
- [Security Trails](https://securitytrails.com/)

## Usage

### Prerequisites

- Bash
- curl
- jq (for parsing JSON responses)

### Running the Script

```bash
./recon_tool.sh <domain>

