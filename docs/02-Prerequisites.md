## Chapter 2 – Prerequisites

Before embarking on your journey to build an AI-powered CTO team, ensure you have the necessary components in place. This chapter presents all requirements in an easy-to-follow checklist format.

### Required Components

#### Core Infrastructure
- ✅ **n8n instance** (self-hosted or cloud)
  - Version 1.0+ recommended
  - Accessible via web browser
  - Sufficient resources (minimum 2GB RAM, 2 CPU cores)
  
- ✅ **Docker** installed on homelab server(s)
  - Docker Engine 20.10+ or Docker Desktop
  - Docker Compose (optional but recommended)
  - User permissions configured for Docker commands
  
- ✅ **LLM API Access**
  - OpenAI API key (GPT-4o-mini or GPT-4 recommended)
  - Alternative: Anthropic Claude, Google Gemini, or local LLMs via Ollama
  - Sufficient API credits or quota
  - API key stored securely (environment variables recommended)

- ✅ **Telegram Account + Bot**
  - Personal Telegram account
  - Bot created via @BotFather
  - Bot token obtained
  - Your Chat ID identified (we'll cover how to get this in Chapter 5)

### Service Access Requirements

The beauty of this system is that it works with your **existing infrastructure**. You don't need to migrate services or change your setup. The agents simply integrate with what you already have running.

- ✅ **Uptime Kuma** - Monitoring Integration
  - Access to Uptime Kuma API
  - API endpoint URL
  - API key or authentication credentials
  
- ✅ **Proxmox** - Virtualization Management
  - Proxmox VE 7.0+ installed
  - SSH access to Proxmox host
  - API credentials (optional, for API-based management)
  - Network access to Proxmox web interface
  
- ✅ **UniFi Controller** - Network Management
  - UniFi Controller running (Cloud Key, UDM, or self-hosted)
  - Admin credentials or API access
  - Controller URL/IP address
  - UniFi site ID (if managing multiple sites)
  
- ✅ **NAS Systems** (e.g., ZimaCube, TrueNAS, Synology)
  - SSH access enabled
  - Monitoring tools available (smartctl for disk health)
  - Network access to NAS interface
  - Read access to system logs
  
- ✅ **Plex Media Server**
  - Plex instance running
  - HTTP access for health checks
  - Docker container name (if containerized)
  - API token (for advanced monitoring)

### Optional but Highly Recommended

- ✅ **Secure Remote Access**
  - VPN (WireGuard, OpenVPN, or similar)
  - Twingate (zero-trust network access)
  - Cloudflare Tunnel (for web services)
  - Tailscale (mesh VPN)
  
- ✅ **SSH Key Authentication**
  - SSH keys generated (ed25519 or RSA 4096-bit)
  - Public keys installed on target servers
  - SSH config file configured for easy access
  - Passphrase-protected private keys
  
- ✅ **Knowledge & Skills**
  - Basic understanding of Docker and containerization
  - Familiarity with n8n workflow editor
  - Comfort with command-line interfaces
  - Understanding of your network topology
  - JSON syntax knowledge (for configuration and output parsing)

### Pre-Installation Checklist

Before proceeding to Chapter 3, verify you have completed:

```
[ ] n8n is installed and accessible
[ ] Docker is running on at least one server
[ ] LLM API key is obtained and tested
[ ] Telegram bot is created and token is saved
[ ] Network access to all services is confirmed
[ ] SSH keys are configured (if using SSH-based integrations)
[ ] You have admin/root access to your infrastructure
[ ] Backup systems are in place (never automate without backups!)
```

**Important Security Note**: This system will have significant access to your infrastructure. Treat API keys, bot tokens, and SSH credentials with the same care you would give to root passwords. Use environment variables, secrets managers, or n8n's built-in credential system. Never commit credentials to version control.

---

