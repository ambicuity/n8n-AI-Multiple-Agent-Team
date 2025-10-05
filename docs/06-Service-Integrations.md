## Chapter 6 – Service Integrations

This chapter provides detailed integration guides for common homelab services. Each section includes API endpoints, authentication methods, example commands, and agent configuration snippets. These integrations transform your agent from a generic monitor into a service-aware expert.

### Section 6.1: Uptime Kuma Integration

Uptime Kuma is a powerful self-hosted monitoring solution. Integrating it with your AI agent creates a dual-layer monitoring system where Uptime Kuma provides the raw data and your agent provides intelligent analysis.

#### API Access Setup

**Step 1: Enable API in Uptime Kuma**

1. Open Uptime Kuma web interface
2. Navigate to **Settings → Security**
3. Enable **"API Access"**
4. Generate an API key
5. Save the key securely

**Step 2: Test API Access**

```bash
# Get all monitors
curl -X GET "http://your-uptime-kuma:3001/api/monitors" \
  -H "Authorization: Bearer YOUR_API_KEY"

# Get specific monitor status
curl -X GET "http://your-uptime-kuma:3001/api/monitor/1" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

#### n8n Configuration

**Add HTTP Request Node**:
```
Node: HTTP Request
Method: GET
URL: http://your-uptime-kuma:3001/api/monitors
Authentication: Generic Credential Type
  Header Auth:
    Name: Authorization
    Value: Bearer YOUR_API_KEY
```

#### Agent System Prompt Addition

```
UPTIME KUMA INTEGRATION:

You have access to Uptime Kuma monitoring data via HTTP requests.

Available Endpoints:
- GET /api/monitors - List all monitors
- GET /api/monitor/{id} - Get specific monitor details
- GET /api/monitor/{id}/heartbeat - Get heartbeat history

When analyzing service health:
1. First check Uptime Kuma for historical data
2. Identify patterns (recent downtime, recurring issues)
3. Correlate with current checks
4. Provide context: "Service has been down 3 times in last 24 hours"

Example Response Schema:
{
  "monitors": [
    {
      "id": 1,
      "name": "Website",
      "url": "http://192.168.1.100:8090",
      "type": "http",
      "active": true,
      "uptime": 99.5,
      "avgPing": 145
    }
  ]
}
```

#### Example Agent Interaction

```
User: "Is my website performing normally?"

Agent: "Checking current status and historical data..."

[Executes HTTP Request to Uptime Kuma API]
[Executes direct HTTP check to website]

Agent: "📊 Website Health Report:

Current Status: UP ✅
- URL: http://192.168.1.100:8090
- Response Code: 200 OK
- Response Time: 152ms

Historical Performance (Uptime Kuma):
- 24h Uptime: 99.8%
- 7d Uptime: 98.2%
- Average Ping: 145ms
- Incidents: 2 brief outages in past week

Analysis:
Overall healthy, but noticed 2 short outages last week. 
Recommend investigating logs for root cause of intermittent issues.

Would you like me to investigate the cause of recent outages?"
```

#### Advanced: Uptime Kuma Webhook Integration

Configure Uptime Kuma to push alerts to n8n:

**In Uptime Kuma**:
1. Settings → Notifications
2. Add Notification: Webhook
3. URL: `https://your-n8n.com/webhook/uptime-alert`
4. Assign to monitors

**In n8n**:
```
[Webhook Trigger: /webhook/uptime-alert]
  → [AI Agent: Analyze Uptime Kuma Alert]
  → [Telegram: Notify with Context]
```

This enables real-time alerts with AI-powered analysis.

---

### Section 6.2: UniFi Network Monitoring

Monitor your network infrastructure by integrating with UniFi Controller. The agent can check connected devices, bandwidth usage, Wi-Fi health, and security events.

#### API Access Setup

**Step 1: Obtain UniFi Credentials**

You'll need:
- UniFi Controller URL/IP
- Admin username and password
- Site ID (usually "default" for single-site setups)

**Step 2: Authenticate and Get API Cookie**

UniFi API requires cookie-based authentication:

```bash
# Login and get cookie
curl -X POST https://unifi.local:8443/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"your_password"}' \
  -c /tmp/unifi_cookie.txt -k

# Use cookie for requests
curl -X GET https://unifi.local:8443/api/s/default/stat/sta \
  -b /tmp/unifi_cookie.txt -k
```

#### Common API Endpoints

```bash
# List all connected clients
GET /api/s/default/stat/sta

# List all access points
GET /api/s/default/stat/device

# Get site statistics
GET /api/s/default/stat/sitedpi

# List recent alerts/events
GET /api/s/default/stat/alarm

# Get specific device info
GET /api/s/default/stat/device/{mac}
```

#### n8n Workflow for UniFi

**Challenge**: UniFi requires session cookies. Use a subworkflow for authentication:

**Subworkflow: UniFi Authenticate**
```
[Execute Workflow Trigger]
  → [HTTP Request: Login]
      URL: https://unifi.local:8443/api/login
      Method: POST
      Body: {"username":"{{$env.UNIFI_USER}}","password":"{{$env.UNIFI_PASS}}"}
      SSL: Ignore SSL Issues
  → [Set: Extract Cookie]
      cookie: {{ $json.headers['set-cookie'][0] }}
  → [Respond to Workflow]
      cookie: {{ $json.cookie }}
```

**Main Workflow: UniFi Monitor**
```
[Schedule Trigger]
  → [Execute Workflow: UniFi Authenticate]
  → [HTTP Request: Get Clients]
      URL: https://unifi.local:8443/api/s/default/stat/sta
      Headers: Cookie: {{ $json.cookie }}
  → [AI Agent: Analyze Network Health]
  → [Telegram: Report]
```

#### Agent System Prompt for UniFi

```
UNIFI NETWORK MONITORING:

You have access to UniFi Controller data for network analysis.

Available Data:
- Connected clients (wired + wireless)
- Access point status and performance
- Bandwidth usage per client
- Network events and alerts
- Wi-Fi channel utilization

Analysis Tasks:
1. Client Count Monitoring
   - Normal range: 15-25 devices
   - Alert if sudden change (±5 devices)
   - Identify new/unknown devices

2. Bandwidth Analysis
   - Identify high-usage clients
   - Detect unusual traffic patterns
   - Alert on saturation (>80% utilization)

3. Wi-Fi Health
   - Check AP uptime
   - Monitor client signal strength
   - Detect interference or congestion

4. Security Events
   - Failed authentication attempts
   - New device connections
   - Rogue AP detection

Example Response:
{
  "network_health": "good",
  "total_clients": 22,
  "new_devices": 1,
  "bandwidth_usage": "45%",
  "access_points": [
    {
      "name": "Living Room AP",
      "status": "online",
      "clients": 8,
      "uptime": "15 days"
    }
  ],
  "alerts": [
    {
      "type": "new_device",
      "device": "iPhone 14 Pro",
      "mac": "aa:bb:cc:dd:ee:ff",
      "timestamp": "2024-01-15T14:30:00Z"
    }
  ]
}
```

#### Example Commands for Agent

```javascript
// In Execute Command node - UniFi CLI (if SSH access available)
// These commands work when SSH'd into UniFi hardware

// Show connected clients
mca-cli-op info

// Show AP status
mca-cli-op list-devices

// Restart AP (specific MAC)
mca-cli-op restart-device <ap-mac-address>

// Show network stats
mca-cli-op stat
```

#### Example Agent Interaction

```
User: "How many devices are on my network?"

Agent: "Checking UniFi Controller..."

[Authenticates to UniFi]
[Fetches client list]

Agent: "🌐 Network Status:

Total Devices: 23 clients

Breakdown:
- Wired: 8 devices
  (Server, Desktop, NAS, Printer, 4x IoT)
- Wireless (2.4GHz): 6 devices
  (Smart home devices, older phones)
- Wireless (5GHz): 9 devices
  (Laptops, phones, tablets)

Access Points:
✅ Living Room AP - 8 clients, -45dBm avg signal
✅ Office AP - 11 clients, -48dBm avg signal
✅ Bedroom AP - 4 clients, -42dBm avg signal

New Device Detected:
⚠️ Unknown device connected 15 minutes ago
   MAC: aa:bb:cc:dd:ee:ff
   Hostname: Galaxy-S23
   Location: Living Room AP

All systems operating normally. Would you like details on any specific device?"
```

---

### Section 6.3: Proxmox Integration

Proxmox VE manages your virtual machines and containers. Integration enables VM health monitoring, resource usage tracking, and automated management tasks.

#### Authentication Options

**Option 1: SSH Access** (Recommended for comprehensive control)
**Option 2: API Access** (Better for read-only monitoring)

#### SSH-Based Integration

**Step 1: Configure SSH Keys**

```bash
# On your n8n server, generate SSH key if not exists
ssh-keygen -t ed25519 -C "n8n-agent"

# Copy public key to Proxmox host
ssh-copy-id root@proxmox.local

# Test connection
ssh root@proxmox.local "pvesh get /nodes/pve/status"
```

**Step 2: Create Subworkflow for Proxmox Commands**

n8n Subworkflow: **Proxmox SSH Execute**
```
[Execute Workflow Trigger]
  Parameters:
    - command (string): Command to execute
    - node_name (string): Proxmox node name (default: "pve")
    
  → [Execute Command: SSH to Proxmox]
      Command: ssh root@proxmox.local "{{ $json.command }}"
      
  → [Code: Parse Output]
      (Parse JSON or text output)
      
  → [Respond to Workflow]
      result: {{ $json.parsed_output }}
```

**Step 3: Useful Proxmox Commands**

```bash
# List all VMs and containers
pvesh get /nodes/pve/qemu
pvesh get /nodes/pve/lxc

# Get VM status
qm status 100  # VM ID 100

# Get container status
pct status 101  # CT ID 101

# List all resources (VMs, CTs, storage)
pvesh get /cluster/resources

# Get node status (CPU, RAM, uptime)
pvesh get /nodes/pve/status

# Check storage
pvesh get /nodes/pve/storage

# Get VM config
qm config 100

# Start/Stop VM
qm start 100
qm stop 100

# Start/Stop container
pct start 101
pct stop 101

# Check disk usage
df -h

# Check ZFS pools (if using ZFS)
zpool status
```

#### API-Based Integration

**Step 1: Create API Token**

1. Login to Proxmox web interface
2. Go to **Datacenter → Permissions → API Tokens**
3. Click **Add**
4. User: root@pam
5. Token ID: n8n-agent
6. Copy the secret (shown only once!)

**Step 2: API Request Format**

```bash
# Authentication
TOKEN="root@pam!n8n-agent=abc123-secret-token-xyz789"

# Get cluster resources
curl -H "Authorization: PVEAPIToken=$TOKEN" \
  https://proxmox.local:8006/api2/json/cluster/resources

# Get specific VM status
curl -H "Authorization: PVEAPIToken=$TOKEN" \
  https://proxmox.local:8006/api2/json/nodes/pve/qemu/100/status/current

# Start VM
curl -X POST -H "Authorization: PVEAPIToken=$TOKEN" \
  https://proxmox.local:8006/api2/json/nodes/pve/qemu/100/status/start
```

**Step 3: n8n HTTP Request Configuration**

```
Node: HTTP Request (Tool for Agent)
Method: GET
URL: https://proxmox.local:8006/api2/json/{{ $json.endpoint }}
Authentication: Generic Credential Type
  Header Auth:
    Name: Authorization
    Value: PVEAPIToken=root@pam!n8n-agent=YOUR_TOKEN_SECRET
SSL: Ignore SSL Issues (if using self-signed cert)
```

#### Agent System Prompt for Proxmox

```
PROXMOX INTEGRATION:

You manage Proxmox VE infrastructure with VMs and containers.

Available Commands (via SSH subworkflow):
- pvesh get /cluster/resources - List all resources
- qm status <vmid> - Get VM status
- pct status <ctid> - Get container status
- qm start/stop <vmid> - Control VMs
- pct start/stop <ctid> - Control containers

VM/Container ID Mapping:
100: Production Web Server (VM)
101: Database Server (Container)
102: Development Environment (VM)
103: Media Server (Container)
104: Monitoring Stack (Container)

Health Check Process:
1. List all resources
2. Check each VM/CT status
3. Verify resource usage (CPU, RAM, Disk)
4. Alert if:
   - VM/CT is stopped unexpectedly
   - CPU usage >90% for >5 minutes
   - RAM usage >95%
   - Disk usage >85%

Example Response:
{
  "proxmox_health": "degraded",
  "total_vms": 3,
  "total_containers": 4,
  "running": 6,
  "stopped": 1,
  "issues": [
    {
      "id": "101",
      "name": "database-server",
      "type": "lxc",
      "status": "stopped",
      "action_needed": "investigate_and_restart"
    }
  ]
}
```

#### Example Workflow: Proxmox Monitoring

```
[Schedule Trigger: Every 10 minutes]
  → [Execute Workflow: Proxmox SSH Execute]
      command: "pvesh get /cluster/resources --output-format json"
  → [Code: Parse and Analyze]
      - Filter for VMs and containers
      - Check status of each
      - Calculate resource usage
  → [AI Agent: Analyze Proxmox Health]
  → [IF: Issues Detected]
       YES → [Telegram: Alert]
             → [IF: Auto-fix Enabled]
                  YES → [Execute Workflow: Proxmox SSH Execute]
                         command: "qm start {{ $json.vmid }}"
                  NO → [Request Approval]
       NO → [End]
```

#### Example Agent Interaction

```
User: "Check all my VMs"

Agent: "Scanning Proxmox cluster..."

[Executes SSH: pvesh get /cluster/resources]

Agent: "🖥️ Proxmox Cluster Status:

Node: pve
Status: Online
Uptime: 42 days
CPU: 15% (4 cores)
RAM: 28.5GB / 64GB (45%)

Virtual Machines:
✅ VM 100: Production Web Server
   Status: Running
   CPU: 2 cores, 8% usage
   RAM: 4GB / 8GB allocated
   Uptime: 15 days

✅ VM 102: Development Environment
   Status: Running
   CPU: 4 cores, 45% usage
   RAM: 8GB / 16GB allocated
   Uptime: 3 days

❌ VM 104: Testing Server
   Status: STOPPED
   Last stopped: 2 hours ago
   
Containers:
✅ CT 101: Database Server (Running)
✅ CT 103: Media Server (Running)
✅ CT 105: Monitoring Stack (Running)

⚠️ Issue Detected:
VM 104 (Testing Server) is stopped unexpectedly.

Would you like me to:
1. Investigate why it stopped (check logs)
2. Restart it
3. Leave it stopped

Please advise."
```

---

### Section 6.4: NAS (ZimaCube) Monitoring

Network Attached Storage health is critical. Monitor disk health, RAID status, capacity, and prevent data loss through proactive alerts.

#### SSH Access to NAS

**Step 1: Enable SSH on ZimaCube/NAS**

(Steps vary by NAS vendor - ZimaCube, TrueNAS, Synology, etc.)

For ZimaCube/Debian-based:
```bash
# SSH into NAS
ssh admin@nas.local

# Install smartmontools if not present
sudo apt update && sudo apt install smartmontools
```

#### Monitoring Commands

**Disk Health (SMART Data)**:
```bash
# List all disks
lsblk

# Check SMART status for a disk
sudo smartctl -H /dev/sda

# Detailed SMART data
sudo smartctl -a /dev/sda

# Check all disks
for disk in /dev/sd?; do
  echo "=== $disk ==="
  sudo smartctl -H $disk
done
```

**RAID Status**:
```bash
# mdadm RAID (software RAID)
cat /proc/mdstat
sudo mdadm --detail /dev/md0

# ZFS pools
zpool status
zpool list

# Check for errors
zpool status -v
```

**Storage Capacity**:
```bash
# Disk usage
df -h

# Specific mount point
df -h /mnt/storage

# Check inode usage
df -i
```

**Temperature Monitoring**:
```bash
# Drive temperatures
sudo smartctl -a /dev/sda | grep Temperature

# System temperature (if sensors available)
sensors
```

#### n8n Integration

**Subworkflow: NAS Health Check**
```
[Execute Workflow Trigger]
  → [Execute Command: SSH to NAS]
      Command: ssh admin@nas.local "sudo smartctl -H /dev/sda && cat /proc/mdstat && df -h"
  → [Code: Parse Health Data]
  → [Respond to Workflow]
```

#### Agent System Prompt for NAS

```
NAS STORAGE MONITORING:

You monitor Network Attached Storage health with focus on data integrity.

Available Commands:
- smartctl -H /dev/sdX - Check disk SMART status
- cat /proc/mdstat - Check RAID array status
- df -h - Check disk space
- zpool status - Check ZFS pool status (if applicable)

Disk Mapping:
/dev/sda: 4TB WD Red - RAID Member 1
/dev/sdb: 4TB WD Red - RAID Member 2
/dev/sdc: 4TB WD Red - RAID Member 3
/dev/sdd: 4TB WD Red - RAID Member 4
/dev/md0: RAID 5 Array - Main Storage

Critical Alerts:
1. SMART Status: FAILED → IMMEDIATE attention
2. RAID: Degraded → HIGH priority
3. Disk Space: >85% → MEDIUM priority
4. Temperature: >50°C → Monitor closely

Health Check Response:
{
  "nas_health": "healthy|degraded|critical",
  "disks": [
    {
      "device": "/dev/sda",
      "smart_status": "PASSED|FAILED",
      "temperature": "38°C",
      "errors": 0,
      "hours_on": 15234
    }
  ],
  "raid": {
    "device": "/dev/md0",
    "level": "raid5",
    "status": "active|degraded|failed",
    "disks": "4/4",
    "health": "good"
  },
  "capacity": {
    "total": "10.9TB",
    "used": "7.2TB",
    "available": "3.7TB",
    "percent_used": 66
  }
}

CRITICAL: Never attempt automated fixes for storage issues.
Always alert human for disk/RAID problems.
```

#### Example Commands for Different NAS Types

**Synology**:
```bash
# RAID status
cat /proc/mdstat

# Storage pool info
synoraid --type=usage

# Disk health
synodisk --enum
```

**TrueNAS**:
```bash
# Pool status
zpool status

# SMART test
smartctl -t short /dev/da0

# Disk temperature
sysctl -a | grep temperature
```

**Generic Linux NAS**:
```bash
# Complete health check script
#!/bin/bash
echo "=== DISK SMART STATUS ==="
for disk in /dev/sd?; do
  echo "Checking $disk..."
  sudo smartctl -H $disk | grep "SMART overall"
done

echo "=== RAID STATUS ==="
cat /proc/mdstat

echo "=== DISK SPACE ==="
df -h | grep -E "(/mnt|/media|raid)"

echo "=== DISK TEMPERATURES ==="
for disk in /dev/sd?; do
  temp=$(sudo smartctl -a $disk | grep Temperature_Celsius | awk '{print $10}')
  echo "$disk: ${temp}°C"
done
```

#### Example Agent Interaction

```
User: "Check NAS health"

Agent: "Running comprehensive NAS diagnostics..."

[Executes SSH to NAS: full health check script]

Agent: "💾 NAS Health Report:

Overall Status: ✅ HEALTHY

RAID Array:
✅ /dev/md0 (RAID 5)
   - Status: Active, no degradation
   - Disks: 4/4 active
   - Sync: 100% complete
   - Consistency: All checks passed

Individual Disks:
✅ /dev/sda (4TB WD Red)
   - SMART: PASSED
   - Temperature: 38°C ✅
   - Power-on Hours: 15,234
   - Reallocated Sectors: 0 ✅
   
✅ /dev/sdb (4TB WD Red)
   - SMART: PASSED
   - Temperature: 39°C ✅
   - Power-on Hours: 15,198
   - Reallocated Sectors: 0 ✅

✅ /dev/sdc (4TB WD Red)
   - SMART: PASSED
   - Temperature: 37°C ✅
   - Power-on Hours: 12,456
   - Reallocated Sectors: 0 ✅

⚠️ /dev/sdd (4TB WD Red)
   - SMART: PASSED
   - Temperature: 42°C ⚠️ (elevated)
   - Power-on Hours: 18,732
   - Reallocated Sectors: 2 ⚠️ (monitor)

Storage Capacity:
Total: 10.9TB
Used: 7.2TB (66%)
Available: 3.7TB
Status: Healthy headroom

Recommendations:
1. Monitor /dev/sdd temperature - slightly elevated
2. Watch /dev/sdd for increasing reallocated sectors
3. Consider planning disk replacement for /dev/sdd within 6-12 months
4. Current capacity usage is healthy (66%)
5. Next scheduled check: 24 hours

All critical systems operational. Data is safe."
```

---

### Section 6.5: Plex Media Server

Monitor your media server's health, ensure continuous availability, and detect issues with streaming, transcoding, or resource usage.

#### HTTP Health Check

**Basic Availability**:
```bash
# Simple ping
curl -I http://plex.local:32400/web/index.html

# Status endpoint
curl http://plex.local:32400/identity

# Check if server is reachable
curl http://plex.local:32400/status/sessions
```

#### Plex API Access

**Get Token**:
1. Login to Plex web
2. Open any media item
3. Click "Get Info" → "View XML"
4. URL contains: `X-Plex-Token=YOUR_TOKEN`

**API Endpoints**:
```bash
TOKEN="your_plex_token"
PLEX_URL="http://plex.local:32400"

# Get server info
curl "$PLEX_URL?X-Plex-Token=$TOKEN"

# Active sessions (currently streaming)
curl "$PLEX_URL/status/sessions?X-Plex-Token=$TOKEN"

# Library sections
curl "$PLEX_URL/library/sections?X-Plex-Token=$TOKEN"

# Recently added
curl "$PLEX_URL/library/recentlyAdded?X-Plex-Token=$TOKEN"

# Server activities (transcoding, etc.)
curl "$PLEX_URL/activities?X-Plex-Token=$TOKEN"
```

#### Docker Container Monitoring

If running Plex in Docker:
```bash
# Check container status
docker ps -a --filter name=plex

# Container logs
docker logs --tail 100 plex

# Resource usage
docker stats --no-stream plex

# Restart container
docker restart plex

# Check transcoding directory
ls -lh /tmp/plex-transcode/  # or wherever your transcode temp is
```

#### Agent System Prompt for Plex

```
PLEX MEDIA SERVER MONITORING:

You monitor Plex Media Server health and performance.

Available Checks:
1. HTTP health: Ping /web/index.html
2. API status: Get /identity
3. Active sessions: Who's streaming
4. Transcoding: Check /activities
5. Container status: docker ps plex
6. Resource usage: CPU, RAM during transcode

Container Name: plex
Default Port: 32400

Normal Behavior:
- Idle CPU: 5-15%
- Idle RAM: 500MB - 1GB
- Transcoding CPU: 40-80% per stream
- Transcoding RAM: +200MB per stream

Alert Conditions:
- HTTP health check fails (DOWN)
- Container stopped unexpectedly
- CPU >95% sustained (transcoding overload)
- RAM >4GB (possible memory leak)
- Transcoding directory >50GB (stuck transcodes)

Automatic Actions (with approval):
- Restart container if stopped
- Clear transcode directory if >50GB
- Report transcoding bottlenecks

Response Format:
{
  "plex_status": "online|offline|degraded",
  "http_health": "200 OK|error",
  "container_status": "running|stopped",
  "active_streams": 2,
  "transcoding": true,
  "resource_usage": {
    "cpu": "65%",
    "ram": "2.1GB"
  },
  "issues": []
}
```

#### Example Workflow: Plex Monitoring

```
[Schedule Trigger: Every 5 minutes]
  → [HTTP Request: Plex Health Check]
      URL: http://plex.local:32400/identity
  → [Execute Command: Docker Status]
      Command: docker ps -a --filter name=plex --format "{{.Status}}"
  → [AI Agent: Analyze Plex Health]
  → [Code: Check if Action Needed]
  → [IF: Plex Down]
       YES → [Telegram: Alert]
             → [AI Agent: Propose Restart]
             → [Wait for Approval]
             → [Execute Command: docker restart plex]
             → [Wait: 30 seconds]
             → [HTTP Request: Verify Recovery]
             → [Telegram: Confirm]
       NO → [End]
```

#### Example Agent Interaction

```
User: "Why is Plex slow?"

Agent: "Investigating Plex performance..."

[Checks HTTP health]
[Checks container status]
[Checks active sessions]
[Checks resource usage]

Agent: "🎬 Plex Performance Analysis:

Server Status: ONLINE but under heavy load

Active Streams: 3
1. User: John - Avatar (4K) → Transcoding to 1080p
2. User: Sarah - The Office S3E2 (1080p) → Direct Play
3. User: Kids_iPad - Frozen (1080p) → Transcoding to 720p

Resource Usage:
CPU: 178% (1.78 cores) ⚠️ HIGH
RAM: 3.2GB / 4GB (80%)
Transcode Directory: 8.2GB

Root Cause: 
2 simultaneous transcodes from 4K/1080p content.
CPU at capacity, causing buffering.

Recommendations:
1. SHORT-TERM: Ask one user to pause temporarily
2. MEDIUM-TERM: Encourage direct play (matching client capabilities)
3. LONG-TERM: Consider GPU transcoding (QuickSync/NVENC)

Current Bottleneck: CPU-bound transcoding

Would you like me to:
A) Send message to John about 4K transcode load
B) Check transcoding settings
C) Monitor and alert if streams drop"
```

---

### Section 6.6: Integration Best Practices

**Security**:
- Store API keys and tokens in n8n credentials, never in code
- Use read-only accounts initially
- Implement IP whitelisting where possible
- Rotate credentials quarterly

**Reliability**:
- Implement timeouts for all API calls (10-30 seconds)
- Add retry logic for transient failures (3 retries with exponential backoff)
- Cache frequently accessed data to reduce API load

**Performance**:
- Poll less frequently for non-critical services (15-30 minutes)
- Use webhooks instead of polling where supported
- Batch related API calls

**Maintainability**:
- Document each integration's endpoints and authentication
- Create separate subworkflows for complex integrations
- Version control your workflow exports

---

With these integrations in place, your AI agent has deep visibility into every aspect of your homelab. In Chapter 7, we'll explore advanced features like God-Mode prompts and multi-agent collaboration.

---

