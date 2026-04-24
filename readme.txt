# Penetration Testing MCP Server

A Model Context Protocol (MCP) server that provides security testing and penetration testing tools for authorized testing of web applications and networks in educational environments.

## ⚠️ IMPORTANT LEGAL NOTICE

**THIS TOOL IS FOR EDUCATIONAL PURPOSES ONLY**

- Only use on systems you own or have explicit written authorization to test
- Unauthorized penetration testing is illegal and may result in criminal prosecution
- Always obtain proper authorization before conducting security assessments
- Use responsibly in controlled lab environments (DVWA, WebGoat, HackTheBox, etc.)

## Purpose

This MCP server provides a secure interface for AI assistants to perform penetration testing tasks on authorized systems for educational purposes, security research, and vulnerability assessments.

## Features

### Reconnaissance Tools
- **`nmap_scan`** - Network port scanning and service detection
- **`subfinder_enumerate`** - Subdomain enumeration
- **`amass_enumerate`** - Comprehensive subdomain discovery
- **`theharvester_search`** - Email and information gathering

### Web Scanning Tools
- **`nikto_scan`** - Web server vulnerability scanner
- **`dirb_scan`** - Directory and file brute forcing
- **`gobuster_dir`** - Fast directory brute forcing
- **`ffuf_fuzz`** - High-speed web fuzzer
- **`wpscan_wordpress`** - WordPress security scanner

### Vulnerability Scanning
- **`sqlmap_test`** - SQL injection detection and exploitation
- **`xsstrike_scan`** - XSS vulnerability scanner
- **`searchsploit_search`** - Exploit database search

### Password Attacks
- **`hydra_bruteforce`** - Network service password brute forcing
- **`medusa_bruteforce`** - Parallel password cracking
- **`cewl_generate`** - Custom wordlist generation from websites
- **`crunch_generate`** - Pattern-based wordlist generation

### Exploitation Frameworks
- **`msfconsole_search`** - Search Metasploit exploit modules
- **`routersploit_info`** - Router exploitation framework info
- **`linpeas_info`** - Linux privilege escalation enumeration

## Prerequisites

- Docker Desktop with MCP Toolkit enabled
- Docker MCP CLI plugin (`docker mcp` command)
- At least 4GB of free disk space for Kali Linux image
- Target systems you have authorization to test

## Installation

See the step-by-step instructions provided with the files.

## Usage Examples

In Claude Desktop, you can ask:

**Reconnaissance:**
- "Run a basic nmap scan on 192.168.1.100"
- "Enumerate subdomains for example.com using subfinder"
- "Use theHarvester to gather emails for testdomain.com"

**Web Scanning:**
- "Scan http://dvwa.local with nikto"
- "Run gobuster directory scan on http://testsite.local"
- "Fuzz parameters with ffuf on http://target.com/page?FUZZ=test"

**Vulnerability Testing:**
- "Test http://vulnerable-site.local/login.php for SQL injection"
- "Scan http://test.local for XSS vulnerabilities"
- "Search exploitdb for wordpress vulnerabilities"

**Password Testing:**
- "Generate a wordlist from http://target.com using cewl"
- "Create a wordlist with crunch for passwords 4-6 characters using abc123"

**Exploitation Research:**
- "Search metasploit for apache exploits"
- "Find exploits for CVE-2021-44228"

## Architecture
```
Claude Desktop → MCP Gateway → Pentest MCP Server → Security Tools
                                       ↓
                              Kali Linux Container
                           (nmap, nikto, sqlmap, etc.)
```

## Development

### Local Testing
```bash
# Run directly with Python
python3 pentest_server.py

# Test MCP protocol
echo '{"jsonrpc":"2.0","method":"tools/list","id":1}' | python3 pentest_server.py
```

### Adding New Tools

1. Add the function to `pentest_server.py`
2. Decorate with `@mcp.tool()`
3. Ensure proper input sanitization
4. Update the catalog entry with the new tool name
5. Rebuild the Docker image

## Troubleshooting

### Tools Not Appearing
- Verify Docker image built successfully: `docker images | grep pentest`
- Check catalog and registry files
- Ensure Claude Desktop config includes custom catalog
- Restart Claude Desktop completely

### Build Failures
- Kali repository might be temporarily unavailable - retry
- Ensure sufficient disk space (4GB+ free)
- Check Docker daemon is running

### Scan Errors
- Verify target is reachable: `ping target-ip`
- Check firewall rules aren't blocking scans
- Ensure you have authorization to scan the target
- Some tools require specific URL formats (http:// prefix)

## Security Considerations

- Container runs as non-root user when possible
- Input sanitization prevents command injection
- Output is truncated to prevent memory issues
- All scans are logged for audit trail
- No credentials stored in container

## Recommended Test Environments

- **DVWA** (Damn Vulnerable Web Application)
- **WebGoat** (OWASP training app)
- **Metasploitable** (Intentionally vulnerable Linux)
- **OWASP Juice Shop** (Vulnerable web application)
- **HackTheBox** (Legal penetration testing platform)
- **TryHackMe** (Cybersecurity training platform)

## Ethical Guidelines

1. **Authorization First** - Always get written permission
2. **Scope Limitation** - Only test approved systems
3. **Non-Destructive** - Avoid denial-of-service attacks
4. **Responsible Disclosure** - Report vulnerabilities properly
5. **Legal Compliance** - Follow local laws and regulations

## License

MIT License - Educational Use Only

**Remember: With great power comes great responsibility. Use these tools ethically and legally.**