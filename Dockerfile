# Use Kali Linux base image
FROM kalilinux/kali-rolling

# Set working directory
WORKDIR /app

# Set Python unbuffered mode
ENV PYTHONUNBUFFERED=1

# Update and install Python and security tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    nmap \
    nikto \
    sqlmap \
    wpscan \
    dirb \
    exploitdb \
    subfinder \
    theharvester \
    ffuf \
    gobuster \
    hydra \
    medusa \
    cewl \
    crunch \
    metasploit-framework \
    routersploit \
    amass \
    git \
    curl \
    wget \
    libcap2-bin \
    && rm -rf /var/lib/apt/lists/*

# Install linpeas
RUN curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -o /usr/local/bin/linpeas.sh && \
    chmod +x /usr/local/bin/linpeas.sh

# Install xsstrike
RUN git clone https://github.com/s0md3v/XSStrike.git /opt/xsstrike && \
    pip3 install -r /opt/xsstrike/requirements.txt --break-system-packages

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt --break-system-packages --ignore-installed

# Copy the server code
COPY pentest_server.py .

# Create non-root user
RUN useradd -m -u 1000 mcpuser && \
    chown -R mcpuser:mcpuser /app

# Grant network capabilities to nmap (allows raw socket access without root)
RUN setcap cap_net_raw,cap_net_admin,cap_net_bind_service+eip /usr/bin/nmap

# Switch to non-root user
USER mcpuser

# Run the server
CMD ["python3", "pentest_server.py"]