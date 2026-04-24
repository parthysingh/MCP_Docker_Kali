\# Penetration Testing MCP Server - Implementation Guide



\## Overview



This MCP server provides penetration testing capabilities through a Kali Linux Docker container with pre-installed security tools. It's designed for educational security testing on authorized systems only.



\## Architecture



\### Container Design

\- \*\*Base Image\*\*: Kali Linux Rolling (official security testing distribution)

\- \*\*User\*\*: Non-root (mcpuser, UID 1000)

\- \*\*Python\*\*: Python 3 with MCP libraries

\- \*\*Security Tools\*\*: 15+ pre-installed penetration testing tools



\### Tool Categories



1\. \*\*Network Reconnaissance\*\*

&nbsp;  - nmap: Port scanning and service detection

&nbsp;  - amass: DNS enumeration

&nbsp;  - subfinder: Subdomain discovery

&nbsp;  - theHarvester: OSINT gathering



2\. \*\*Web Application Testing\*\*

&nbsp;  - nikto: Web server scanner

&nbsp;  - dirb/gobuster/ffuf: Directory brute forcing

&nbsp;  - wpscan: WordPress security scanner

&nbsp;  - sqlmap: SQL injection testing

&nbsp;  - XSStrike: XSS vulnerability detection



3\. \*\*Password Attacks\*\*

&nbsp;  - hydra/medusa: Network service brute forcing

&nbsp;  - cewl: Website-based wordlist generation

&nbsp;  - crunch: Pattern-based wordlist creation



4\. \*\*Exploitation\*\*

&nbsp;  - metasploit-framework: Exploit development

&nbsp;  - searchsploit: Exploit database search

&nbsp;  - routersploit: Router exploitation



5\. \*\*Post-Exploitation\*\*

&nbsp;  - linpeas: Privilege escalation enumeration



\## Security Implementation



\### Input Sanitization

All user inputs are sanitized using regex patterns:

\- Target validation: `^\[a-zA-Z0-9\\.\\-\\\_\\:\\/]+$`

\- Wordlist paths: `^\[a-zA-Z0-9\\/\\.\\-\\\_]+$`



\### Command Injection Prevention

\- No `shell=True` except where absolutely necessary

\- Parameters passed as list arguments to subprocess

\- Strict input validation before command execution



\### Output Limitations

\- Maximum output length: 50,000 characters

\- Automatic truncation with user notification

\- Timeout protection (5-10 minutes per scan)



\## Tool Usage Guidelines



\### Nmap Scan Types

\- `basic`: Service version detection + default scripts

\- `quick`: Fast scan, common ports only

\- `stealth`: SYN scan, slow timing

\- `udp`: UDP port scan

\- `aggressive`: OS detection, traceroute, scripts

\- `ping`: Host discovery only



\### WordPress Enumeration Options

\- `vp`: Vulnerable plugins

\- `ap`: All plugins

\- `tt`: Timthumbs

\- `cb`: Config backups

\- `dbe`: Database exports

\- `u`: Users



\### Hydra/Medusa Services

Supported services:

\- ssh, ftp, http, https, smtp, mysql, postgresql



\## Best Practices for Claude



\### When Recommending Scans



1\. \*\*Start Conservative\*\*: Begin with non-invasive scans

&nbsp;  - Ping sweeps before port scans

&nbsp;  - Basic nmap before aggressive scans

&nbsp;  - Passive enumeration before active



2\. \*\*Explain Risks\*\*: Inform users about:

&nbsp;  - Potential for detection by IDS/IPS

&nbsp;  - Network impact of aggressive scans

&nbsp;  - Legal implications



3\. \*\*Suggest Proper Sequence\*\*:

```

&nbsp;  Step 1: nmap\_scan (basic) - Identify services

&nbsp;  Step 2: subdomain enumeration - Expand attack surface

&nbsp;  Step 3: Web scanning (nikto/dirb) - Find vulnerabilities

&nbsp;  Step 4: Targeted testing (sqlmap/xsstrike) - Exploit findings

```



\### Error Handling



All tools return formatted strings with:

\- ✅ Success indicator

\- ❌ Error indicator

\- 🔍 Information indicator

\- ⏱️ Timeout indicator



\### Rate Limiting Considerations



Recommend users:

\- Use `-t 4` for parallel tasks (already set in tools)

\- Add delays between scans on production-like systems

\- Monitor target system load



\## Educational Context



\### Suitable Targets

\- Local VMs (Metasploitable, DVWA)

\- Authorized lab environments

\- Personal servers with full ownership

\- Bug bounty programs (with proper authorization)



\### Unsuitable Targets

\- Production systems without authorization

\- Government websites

\- Financial institutions

\- Any system without explicit written permission



\## Troubleshooting Guide



\### Common Issues



\*\*"Command not found" errors:\*\*

\- Tool might not be installed correctly

\- Check Dockerfile build logs

\- Verify PATH includes /usr/local/bin



\*\*Network connectivity issues:\*\*

\- Docker network isolation

\- Use `--network host` for certain scans (requires modification)

\- Firewall rules blocking traffic



\*\*Permission denied:\*\*

\- Some tools require root (nmap SYN scan)

\- Set capabilities in Dockerfile if needed

\- Switch to TCP connect scan (-sT) instead



\*\*Wordlist not found:\*\*

\- Common wordlists in /usr/share/wordlists

\- May need to download rockyou.txt separately

\- Use absolute paths



\## Performance Optimization



\### Resource Management

\- Limit concurrent scans

\- Use timeouts on all operations

\- Truncate large outputs

\- Clean up temporary files



\### Speed vs Stealth

\- Fast scans: `-T4` or `-T5` (more detectable)

\- Stealthy scans: `-T2` or `-T1` (slower, less detectable)

\- Balance based on engagement rules



\## Extension Ideas



Future enhancements could include:

\- Report generation in HTML/PDF

\- Vulnerability correlation

\- Automated exploitation chains

\- Integration with vulnerability databases

\- Custom scan profiles

\- Session management for multi-step tests



\## Legal Disclaimer Template



When Claude recommends using this server, include:

```

⚠️ AUTHORIZATION REQUIRED

Before running any scans, ensure you have:

1\. Written authorization from system owner

2\. Defined scope and limitations

3\. Emergency contact information

4\. Incident response plan



Unauthorized access is illegal under:

\- Computer Fraud and Abuse Act (US)

\- Computer Misuse Act (UK)

\- Similar laws in your jurisdiction

```



\## Logging and Auditing



All operations log to stderr:

\- Timestamp

\- Tool used

\- Target

\- User request



Recommend users:

\- Keep detailed testing notes

\- Document all findings

\- Maintain chain of custody for evidence

\- Store reports securely



\## Integration with Claude Desktop



This server works best when Claude:

1\. Asks about authorization before first use

2\. Suggests appropriate scan sequences

3\. Interprets results and recommends next steps

4\. Explains findings in accessible language

5\. Prioritizes vulnerabilities by severity



\## Version History



\- v1.0: Initial release with 15 security tools

\- Kali Linux base with educational focus

\- Comprehensive input sanitization

\- MCP protocol integration

