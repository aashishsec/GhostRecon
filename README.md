# GhostRecon  -🌐 Passive Reconnaissance Tool for Domain Discovery 🕵️‍♂️

# Reconnaissance Tool

[Tool Link](https://github.com/aashishsec/GhostRecon)

```bash

░██████╗░██╗░░██╗░█████╗░░██████╗████████╗██████╗░███████╗░█████╗░░█████╗░███╗░░██╗
██╔════╝░██║░░██║██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║
██║░░██╗░███████║██║░░██║╚█████╗░░░░██║░░░██████╔╝█████╗░░██║░░╚═╝██║░░██║██╔██╗██║
██║░░╚██╗██╔══██║██║░░██║░╚═══██╗░░░██║░░░██╔══██╗██╔══╝░░██║░░██╗██║░░██║██║╚████║
╚██████╔╝██║░░██║╚█████╔╝██████╔╝░░░██║░░░██║░░██║███████╗╚█████╔╝╚█████╔╝██║░╚███║
░╚═════╝░╚═╝░░╚═╝░╚════╝░╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░╚════╝░░╚════╝░╚═╝░░╚══╝

                     Author : Aashishsec
                     Github : https://github.com/aashishsec
```

Certainly! Below is a GitHub-flavored Markdown documentation for your script:

```markdown
# Reconnaissance Script

This Bash script performs domain reconnaissance by fetching subdomains from various sources and saving them to text files. It organizes the output in a directory and saves the unique sorted domains outside the directory.

## Usage

```bash
./GhostRecon.sh  <domain>
```

Replace `<domain>` with the target domain.

## Dependencies

- Bash
- curl
- jq

## Script Overview

The script performs the following steps:

1. **Wayback Machine (web.archive.org):**
   - Fetches subdomains from the Wayback Machine.
   - Saves results to `web_archive.txt` in the output directory.

2. **crt.sh:**
   - Fetches subdomains from crt.sh.
   - Saves results to `crt.txt` in the output directory.

3. **UrlScan.io:**
   - Fetches subdomains from UrlScan.io (commented out by default).
   - Saves results to `urlscan.txt` in the output directory.

4. **AlienVault:**
   - Fetches subdomains from AlienVault (commented out by default).
   - Saves results to `alienvault.txt` in the output directory.

5. **Security Trails:**
   - Fetches subdomains from Security Trails.
   - Saves results to `${domain}_securitytrails.txt` in the output directory.

6. **Shrewdeye:**
   - Downloads subdomains from Shrewdeye.
   - Saves results to `${domain}.txt`.

7. **Concatenate and Filter:**
   - Concatenates all .txt files.
   - Filters unique domains.
   - Saves results to `all_domains.txt` outside the output directory.

8. **Directory Organization:**
   - Creates an output directory named `recon_output`.
   - Moves all .txt files to the output directory.

## Example

```bash
./recon_script.sh example.com
```

## Output

- `recon_output/`
  - `web_archive.txt`
  - `crt.txt`
  - `urlscan.txt` (commented out by default)
  - `alienvault.txt` (commented out by default)
  - `example.com_securitytrails.txt`
- `all_domains.txt`

Reconnaissance completed successfully. Unique domains saved to `all_domains.txt`.

## Notes

- Ensure you have the necessary permissions and API keys for external services.
- Uncomment sections in the script based on your requirements.

```

Feel free to adjust the documentation as needed and integrate it into your GitHub repository's README or documentation files.

