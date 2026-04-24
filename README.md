# MCP_Docker_Kali

docker build -t pentest-mcp-server .

# Create catalogs directory if it doesn't exist
mkdir -p ~/.docker/mcp/catalogs

# Create or edit custom.yaml
nano ~/.docker/mcp/catalogs/custom.yaml

# Edit registry file
nano ~/.docker/mcp/registry.yaml
