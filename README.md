# n8n-Homelab-CTO-Agent-Team

**AI-Powered Multi-Agent CTO for Your Homelab**

> **Author**: Ritesh Rana ([@ambicuity](https://github.com/ambicuity))  
> **Contact**: [riteshrana36@gmail.com](mailto:riteshrana36@gmail.com)  
> **Website**: [www.riteshrana.engineer](https://www.riteshrana.engineer)

---

## Table of Contents

1. [Chapter 1 – Overview](#chapter-1--overview)
2. [Chapter 2 – Prerequisites](#chapter-2--prerequisites)
3. [Chapter 3 – Initial Setup](#chapter-3--initial-setup)
4. [Chapter 4 – Agent Evolution (Stages)](#chapter-4--agent-evolution-stages)
5. [Chapter 5 – Automation Setup](#chapter-5--automation-setup)
6. [Chapter 6 – Service Integrations](#chapter-6--service-integrations)
7. [Chapter 7 – Advanced Features](#chapter-7--advanced-features)
8. [Chapter 8 – AI Team](#chapter-8--ai-team)
9. [Chapter 9 – Troubleshooting](#chapter-9--troubleshooting)
10. [Chapter 10 – Best Practices](#chapter-10--best-practices)
11. [Chapter 11 – Additional Resources](#chapter-11--additional-resources)
12. [Chapter 12 – Support & Contributions](#chapter-12--support--contributions)

---

## Chapter 1 – Overview

### Purpose of This Repository

This comprehensive guide documents the creation and operation of an **AI-powered multi-agent IT team** built with **n8n**, designed to manage your homelab or business network infrastructure with the intelligence and autonomy of a seasoned **Chief Technology Officer (CTO)**.

Unlike traditional monitoring scripts or simple automation tools, this system embodies a fundamental paradigm shift: **treating AI agents as employees, not bots**. Each agent has a defined role, responsibilities, decision-making capabilities, and the ability to collaborate with other agents to solve complex infrastructure challenges.

### Philosophy: Agents as Employees, Not Bots

Traditional automation follows rigid if-then logic. When Service X goes down, restart it. When disk usage exceeds Y%, send an alert. This approach lacks intelligence, context awareness, and adaptability.

The **n8n-Homelab-CTO-Agent-Team** reimagines infrastructure management by creating a virtual IT department where:

- **Agents have roles**: Just like a real IT team has network administrators, database engineers, and security officers, your AI team has specialized agents with distinct expertise
- **Agents make decisions**: They don't just execute predefined scripts; they analyze situations, weigh options, and choose appropriate actions
- **Agents collaborate**: Complex issues are escalated and multiple agents work together, sharing knowledge and insights
- **Agents learn and adapt**: System prompts can be refined based on experience, creating increasingly capable team members over time
- **Agents respect hierarchy**: Junior agents handle routine tasks, senior agents tackle complex problems, and the CTO agent orchestrates everything

### Real-World Benefits: Saving Time, Money, and Stress

**Time Savings**:
- Automated 24/7 monitoring eliminates manual health checks
- Intelligent diagnostics replace hours of log diving
- Self-healing capabilities handle common issues without human intervention
- Agents work while you sleep, on weekends, and during vacations

**Cost Savings**:
- Reduce downtime and associated revenue loss
- Prevent small issues from becoming expensive disasters
- Maximize infrastructure utilization through intelligent resource management
- Avoid hiring additional IT staff for routine operations
- Leverage existing infrastructure rather than expensive managed services

**Stress Reduction**:
- Human-in-the-loop approval means you stay in control without constant monitoring
- Detailed diagnostics and proposed solutions replace 3 AM panic debugging
- Comprehensive logging creates an audit trail for compliance and troubleshooting
- Proactive issue detection prevents surprise outages
- Peace of mind knowing your infrastructure has intelligent oversight

**Real Example**: Your Plex media server crashes at 2 AM. Traditional monitoring sends an alert, waking you up. With the CTO Agent Team:
1. The monitoring agent detects the issue within minutes
2. The Linux Engineer agent investigates, reading container logs
3. The agent identifies a memory leak as the root cause
4. A fix is proposed: restart the container with increased memory limits
5. An approval request arrives on your phone via Telegram
6. You approve with a single tap, still in bed
7. The agent executes the fix, verifies recovery, and sends confirmation
8. You sleep through the night, and users never notice

This is the power of treating agents as intelligent employees rather than dumb automation scripts.

---

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

## Chapter 3 – Initial Setup

This chapter guides you through creating your first AI agent workflow, starting with a simple demo website for testing. You'll learn the fundamental building blocks: triggers, AI agent nodes, memory systems, and tool integration.

### Section 3.1: Demo Website Setup

Before deploying agents to monitor production services, create a safe testing environment. This demo website allows you to experiment with monitoring, diagnostics, and automated fixes without risking real infrastructure.

#### Step 1: Deploy the Demo Container

Open a terminal on your Docker host and execute:

```bash
# Create and run a simple nginx web server
docker run -d --name website -p 8090:80 nginx

# Customize the homepage
docker exec website sh -c 'echo "<h1>Homelab CTO Agent</h1><p>If you can see this, your agent is monitoring successfully!</p>" > /usr/share/nginx/html/index.html'
```

**What This Does**:
- `docker run -d`: Runs the container in detached (background) mode
- `--name website`: Assigns a friendly name for easy reference
- `-p 8090:80`: Maps port 8090 on your host to port 80 in the container
- `nginx`: Uses the official nginx image from Docker Hub
- The `docker exec` command modifies the default webpage to confirm successful monitoring

#### Step 2: Verify the Deployment

Test that the website is accessible:

```bash
# Test from the Docker host itself
curl http://localhost:8090

# Test from another machine on your network (replace with your server's IP)
curl http://YOUR_SERVER_IP:8090
```

**Expected Output**:
```html
<h1>Homelab CTO Agent</h1><p>If you can see this, your agent is monitoring successfully!</p>
```

If you see this output, your test environment is ready. If not, troubleshoot:
- Is Docker running? (`docker ps` should list the container)
- Is port 8090 available? (`netstat -tulpn | grep 8090`)
- Is your firewall blocking the port? (`sudo ufw status` or check iptables)

#### Step 3: Simulate Failure Scenarios

Your agent needs to handle failures, so let's create some:

```bash
# Scenario 1: Stop the container (service down)
docker stop website

# Verify it's down
curl http://localhost:8090
# Should fail with "Connection refused"

# Scenario 2: Restart it
docker start website

# Scenario 3: Remove and recreate (simulates crash)
docker rm -f website
docker run -d --name website -p 8090:80 nginx
```

These scenarios will be useful when testing your agent's diagnostic and recovery capabilities.

---

### Section 3.2: n8n Workflow Fundamentals

Now that you have a test service, let's build your first monitoring agent in n8n.

#### Understanding the n8n AI Agent Architecture

n8n's AI Agent node is the brain of your system. Here's how it works:

```
┌─────────────────────────────────────────────────────┐
│                   AI Agent Node                      │
│  ┌──────────────────────────────────────────────┐  │
│  │  System Prompt (Role & Instructions)         │  │
│  └──────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────┐  │
│  │  LLM (GPT-4, Claude, etc.)                   │  │
│  └──────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────┐  │
│  │  Memory (Session context)                    │  │
│  └──────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────┐  │
│  │  Tools (HTTP, Docker, SSH, etc.)             │  │
│  └──────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
```

**Components**:
1. **System Prompt**: Defines the agent's personality, role, and capabilities
2. **LLM**: The reasoning engine that makes decisions
3. **Memory**: Maintains conversation context across multiple interactions
4. **Tools**: External capabilities the agent can invoke (HTTP requests, shell commands, etc.)

#### Step-by-Step Workflow Creation

##### Step 1: Create a New Workflow

1. Open your n8n instance in a web browser
2. Click **"+ Add Workflow"** or navigate to **Workflows → New**
3. Give it a meaningful name: `"Homelab Monitor - Stage 1"`

##### Step 2: Add a Manual Trigger

1. In the workflow editor, click the **"+"** button
2. Search for **"Manual Trigger"** or **"When clicking 'Execute Workflow'"**
3. Add this node to your canvas
4. This trigger allows you to test the workflow manually before automating it

##### Step 3: Add the AI Agent Node

1. Click the **"+"** button after your trigger
2. Search for **"AI Agent"**
3. Add the **"AI Agent"** node to your workflow
4. Connect it to the Manual Trigger

##### Step 4: Configure the AI Agent

Click on the AI Agent node to open its configuration panel:

**Model Configuration**:
- **Chat Model**: Select or create an OpenAI account credential
  - Click **"Create New Credential"**
  - Enter your OpenAI API key
  - Save the credential
- **Model**: Choose **GPT-4o-mini** (cost-effective) or **GPT-4** (more capable)

**Memory Configuration**:
- Click **"Add Memory"**
- Select **"Window Buffer Memory"** or **"Simple Session Memory"**
- This allows the agent to remember context within a single workflow execution

**System Prompt**:
This is where you define your agent's role. For your first monitoring agent, use:

```
You are a professional homelab monitoring agent. Your role is to check the health of services and report their status clearly.

When asked to check a service:
1. Use the HTTP request tool to check if the service is responding
2. Report the HTTP status code
3. Indicate if the service is UP (200-299 status) or DOWN (any other status or connection failure)
4. Be concise but informative

Always maintain a professional tone and provide actionable information.
```

##### Step 5: Add HTTP Request Tool

The agent needs tools to interact with the outside world. Let's give it the ability to make HTTP requests:

1. In the AI Agent configuration, scroll to **"Tools"**
2. Click **"Add Tool"**
3. Select **"HTTP Request"**
4. A new HTTP Request node will appear, connected to your AI Agent

**Configure the HTTP Request Node**:
- **Authentication**: None (for this simple test)
- **Request Method**: GET
- **URL**: Leave this empty - the agent will provide the URL dynamically
- Under **Options**:
  - Enable **"Ignore SSL Issues"** if testing with self-signed certificates
  - Set **"Timeout"** to 10000ms (10 seconds)

##### Step 6: Test Your First Agent

1. Click **"Execute Workflow"** in the top right
2. When the Manual Trigger activates, the Agent awaits input
3. In the chat interface that appears, type:
   ```
   Please check if http://YOUR_SERVER_IP:8090 is online
   ```
4. Watch as the agent:
   - Receives your request
   - Decides to use the HTTP Request tool
   - Makes the request
   - Analyzes the response
   - Reports back with status

**Expected Response**:
```
The service at http://YOUR_SERVER_IP:8090 is UP. 
HTTP Status: 200 OK
The website responded successfully.
```

Congratulations! You've just created your first AI agent. It can now monitor services by making HTTP requests and intelligently reporting results.

---

### Section 3.3: Understanding the Components

Let's examine what just happened:

#### The AI Agent Node

The AI Agent node is not a simple script executor. It's an intelligent reasoning system that:
- **Interprets** your natural language request
- **Plans** the steps needed to fulfill the request
- **Selects** appropriate tools from those available
- **Executes** the tools with correct parameters
- **Analyzes** the results
- **Responds** with human-readable output

You didn't write code to parse URLs, make HTTP requests, or format responses. The LLM handled all of that based on your system prompt and available tools.

#### The Memory Component

Memory allows the agent to maintain context:

**Without Memory**:
```
You: "Check example.com"
Agent: "It's up"
You: "What was the response time?"
Agent: "I don't know what you're referring to"  ❌
```

**With Memory**:
```
You: "Check example.com"
Agent: "It's up, responded in 245ms"
You: "What was the response time?"
Agent: "The response time was 245ms"  ✅
```

For homelab monitoring, memory enables multi-turn conversations:
```
You: "Check all my services"
Agent: "Plex is up, Proxmox is up, but website is down"
You: "Investigate the website issue"
Agent: "Checking Docker container status..."
You: "Can you restart it?"
Agent: "I need approval to restart containers. Should I proceed?"
```

#### The HTTP Request Tool

Tools are the agent's hands in the physical (or digital) world. The HTTP Request tool enables:
- Service health checks
- API interactions
- Webhook triggers
- Data retrieval from web services

In later chapters, you'll add more tools:
- **Execute Command** for Docker and SSH operations
- **Code** for custom logic
- **Subworkflow** for complex multi-step procedures
- **Telegram** for notifications and approvals

---

### Section 3.4: Next Steps

You now have a functional AI monitoring agent. In Chapter 4, we'll evolve this basic monitor into an intelligent diagnostic and self-healing system through five progressive stages.

**What You've Accomplished**:
- ✅ Created a safe testing environment with a demo website
- ✅ Built your first n8n workflow with an AI Agent
- ✅ Configured the agent with a system prompt, memory, and tools
- ✅ Successfully monitored a service using natural language commands

**Prepare for Chapter 4**:
- Keep your demo website running
- Familiarize yourself with the n8n interface
- Consider what additional capabilities you'd like your agent to have
- Think about which production services you'll eventually want to monitor

---

## Chapter 4 – Agent Evolution (Stages)

The journey from a simple monitoring script to an intelligent, self-healing infrastructure guardian follows a carefully designed progression. Each stage builds upon the previous one, adding new capabilities while maintaining safety and control. This chapter details five evolutionary stages, complete with system prompts, required tools, and real-world examples.

### Stage 1: Basic Monitor

**Capability Overview**: Check uptime via HTTP health checks

At this foundational stage, your agent performs basic service availability monitoring. It can check if web services respond and report their HTTP status codes. This is similar to traditional uptime monitoring tools but with natural language interaction.

**What It Can Do**:
- Monitor website and API availability via HTTP/HTTPS
- Return HTTP status codes and basic response information
- Report simple UP/DOWN status
- Detect connection timeouts and network issues
- Check multiple services sequentially

**What It Cannot Do**:
- Diagnose WHY a service is down
- Access system logs or container information
- Make any changes to infrastructure
- Understand complex failure patterns

**Required Tools**:
- HTTP Request node (configured as a tool)

**System Prompt Example**:
```
You are a Level 1 Homelab Monitoring Agent. Your role is to check service availability and report status.

CAPABILITIES:
- Check HTTP/HTTPS endpoints
- Report status codes and response times
- Identify if services are UP (200-299) or DOWN (any other status/error)

LIMITATIONS:
- You cannot diagnose issues beyond HTTP responses
- You cannot make any changes to systems
- You cannot access logs or system internals

OUTPUT FORMAT:
For each service checked, report:
- Service name/URL
- Status (UP/DOWN)
- HTTP status code (if available)
- Response time
- Any error messages

Always be clear and concise. If a service is down, state that further investigation is needed.
```

**Example Interaction**:
```
User: "Check if my Plex server at http://192.168.1.100:32400 is online"

Agent: "Checking Plex server..."
[Executes HTTP Request tool]

Agent: "✅ Status Report:
Service: Plex Media Server
URL: http://192.168.1.100:32400
Status: UP
HTTP Code: 200 OK
Response Time: 145ms

Your Plex server is online and responding normally."
```

**When to Use Stage 1**:
- Initial setup and testing
- Low-risk monitoring scenarios
- Services you want visibility into but not automated intervention
- Learning how the agent system works

---

### Stage 2: Smart Investigator

**Capability Overview**: Use Docker commands and log analysis to diagnose issues

Stage 2 agents can go beyond surface-level checks. When a service is down, they investigate the underlying cause by examining Docker container status and reading logs. This is where your agent begins to act like a junior system administrator.

**What It Can Do**:
- List all Docker containers and their states
- Check if specific containers are running, stopped, or crashed
- Read container logs (last 50-100 lines)
- Identify common error patterns in logs
- Correlate service failures with container issues
- Provide diagnostic insights about root causes

**What It Cannot Do**:
- Restart containers or make changes
- Access host system logs (only container logs)
- Modify configurations
- Interact with services via SSH

**Required Tools**:
- HTTP Request node (for service checks)
- Execute Command node (for Docker CLI access)

**Configure Execute Command Node**:
```
Node Settings:
- Command: {{ $json.command }}  (receives command from agent)
- Execute Once: Yes
```

**System Prompt Example**:
```
You are a Level 2 Homelab Diagnostic Agent with investigation capabilities.

CAPABILITIES:
- Check HTTP/HTTPS service availability
- List Docker containers (docker ps -a)
- Check container status (docker inspect <container>)
- Read container logs (docker logs --tail 100 <container>)
- Analyze log patterns for common errors

DIAGNOSTIC PROCESS:
1. When a service is DOWN, first check if it's containerized
2. Use 'docker ps -a' to find the container
3. Check container state (running, exited, restarting)
4. If stopped/crashed, read logs with 'docker logs --tail 100 <name>'
5. Analyze logs for:
   - Error messages
   - Out of memory conditions
   - Port conflicts
   - Permission issues
   - Application crashes
6. Provide a diagnostic summary

OUTPUT FORMAT:
Service: [name]
Status: [UP/DOWN]
Container Status: [running/stopped/crashed]
Root Cause: [your diagnosis based on logs]
Relevant Logs: [key error messages]
Recommended Action: [what should be done]

LIMITATIONS:
- You can diagnose but NOT fix issues
- You cannot restart containers
- You cannot modify any configurations
- Always recommend actions but never execute them

Be thorough but concise. Focus on actionable insights.
```

**Docker Commands Available to Agent**:
```bash
# List all containers
docker ps -a

# Check specific container
docker ps -a --filter name=website

# Get container logs
docker logs --tail 100 website

# Inspect container details
docker inspect website

# Check container resource usage
docker stats --no-stream website
```

**Example Interaction**:
```
User: "My website at http://192.168.1.100:8090 is down. What's wrong?"

Agent: "Investigating the issue..."

[Checks HTTP - fails]
[Executes: docker ps -a --filter name=website]
[Finds container is stopped]
[Executes: docker logs --tail 100 website]

Agent: "🔍 Diagnostic Report:

Service: Website (http://192.168.1.100:8090)
Status: DOWN
Container Status: Exited (stopped)
Exit Code: 137 (Out of Memory)

ROOT CAUSE:
The container was killed by the system due to memory exhaustion.

RELEVANT LOGS:
2024-01-15 14:23:45 nginx: worker process out of memory
2024-01-15 14:23:46 Killed

RECOMMENDED ACTION:
Restart the container with increased memory limits:
docker run -d --name website --memory=512m -p 8090:80 nginx

This will prevent future OOM kills."
```

**When to Use Stage 2**:
- Production monitoring where you want diagnostics but not automated fixes
- Learning about common failure patterns in your infrastructure
- Environments where you prefer manual intervention after diagnosis
- Building confidence in the agent's analytical capabilities

---

### Stage 3: The Fixer

**Capability Overview**: Automatically restart containers when they fail

Stage 3 introduces the agent's first automated remediation capability. It can now detect failures and execute fixes autonomously. This is powerful but requires careful consideration of safety boundaries.

**What It Can Do**:
- Everything from Stages 1 and 2 (monitor and diagnose)
- Restart stopped or crashed Docker containers
- Verify that restarts were successful
- Report actions taken with before/after status
- Handle simple recovery scenarios automatically

**What It Cannot Do**:
- Modify container configurations
- Create or destroy containers
- Change port mappings or volume mounts
- Access resources outside Docker

**Required Tools**:
- HTTP Request node
- Execute Command node (with Docker restart permissions)

**System Prompt Example**:
```
You are a Level 3 Homelab Automation Agent with limited remediation capabilities.

CAPABILITIES:
- All diagnostic capabilities from Level 2
- Container restart capability
- Post-restart verification

DECISION FRAMEWORK:
When you detect a DOWN service:
1. Investigate using diagnostic tools
2. If root cause is container stopped/crashed AND
   - Container has no dependencies OR
   - It's a simple restart scenario
3. Attempt automatic restart
4. Verify service recovery
5. Report complete incident details

SAFE-TO-RESTART CRITERIA:
✅ Container exited cleanly (exit code 0)
✅ Container crashed (exit codes 1, 137, 139)
✅ Service is stateless or has persistent data volumes
✅ No configuration changes needed

DO NOT RESTART IF:
❌ Container is in restart loop (>3 restarts in 5 minutes)
❌ Logs show configuration errors
❌ Database or data corruption indicated
❌ Resource exhaustion that restart won't fix

RESTART COMMAND:
docker restart <container_name>

POST-RESTART VERIFICATION:
1. Wait 10 seconds
2. Check container status: docker ps --filter name=<container>
3. Verify HTTP endpoint if applicable
4. Confirm service is UP

OUTPUT FORMAT:
🔧 Incident Report:
Service: [name]
Issue Detected: [timestamp]
Root Cause: [diagnosis]
Action Taken: Restarted container '<name>'
Verification: [service status after restart]
Resolution Time: [duration]

Always log every action taken for audit purposes.
```

**Example Interaction**:
```
[Automatic execution - scheduled every 5 minutes]

Agent: "🔧 Automated Fix Executed

Incident Report:
Service: Website (http://192.168.1.100:8090)
Issue Detected: 2024-01-15 14:25:00
Root Cause: Container stopped (exit code 0 - clean shutdown)

Action Taken: 
- Executed: docker restart website
- Container restarted successfully

Verification:
- Container Status: Running (uptime: 15 seconds)
- HTTP Check: 200 OK
- Response Time: 142ms

Resolution Time: 18 seconds
Service Status: ✅ RESTORED"
```

**Safety Considerations for Stage 3**:

⚠️ **Critical Warning**: Stage 3 agents make automated changes to your infrastructure. Before deploying:

1. **Test Thoroughly**: Run for weeks in a test environment
2. **Start with Non-Critical Services**: Don't enable on production databases initially
3. **Monitor the Monitor**: Set up alerting for agent actions
4. **Have Rollback Plans**: Know how to disable the agent quickly
5. **Implement Rate Limiting**: Prevent restart loops

**Recommended Configuration**:
```json
{
  "max_restarts_per_hour": 3,
  "cooldown_between_restarts": 300,
  "blacklisted_containers": ["database", "postgres", "mysql"],
  "notification_channel": "telegram",
  "log_all_actions": true
}
```

**When to Use Stage 3**:
- Mature monitoring setups where failure patterns are well understood
- Stateless services that can safely restart
- Non-production environments initially
- Services with good health checks and fast startup times
- When you're comfortable with autonomous remediation

---

### Stage 4: Creative Problem Solver

**Capability Overview**: Resolve complex issues like port conflicts, resource exhaustion, and configuration problems

Stage 4 agents move beyond simple restarts. They can identify and resolve complex infrastructure issues that would typically require experienced system administrator intervention.

**What It Can Do**:
- Identify port conflicts and suggest remapping
- Detect memory/disk space issues and recommend solutions
- Analyze resource consumption patterns
- Suggest container optimization (resource limits, restart policies)
- Handle multi-container dependency issues
- Propose configuration changes to prevent recurring issues

**What It Cannot Do**:
- Directly modify system configurations (proposes changes only)
- Make changes without approval (transitions to Stage 5 requirement)
- Access resources outside the Docker/local system scope

**Required Tools**:
- HTTP Request node
- Execute Command node (Docker + system commands)
- Code node (for complex logic and calculations)

**System Prompt Example**:
```
You are a Level 4 Homelab Senior Engineer Agent with advanced problem-solving capabilities.

CAPABILITIES:
- All previous level capabilities
- Resource conflict resolution
- Performance optimization
- Configuration troubleshooting
- Dependency analysis

ADVANCED DIAGNOSTIC COMMANDS:
- docker ps -a (container list)
- docker logs --tail 200 <container>
- docker inspect <container>
- docker stats --no-stream
- netstat -tulpn (port usage)
- df -h (disk space)
- free -m (memory usage)
- systemctl status docker

PROBLEM-SOLVING SCENARIOS:

1. PORT CONFLICTS:
   Detection: "bind: address already in use"
   Solution: Identify conflicting process, suggest alternative port
   Example: "Port 8080 used by process X. Recommend using 8081"

2. MEMORY EXHAUSTION:
   Detection: Exit code 137, OOM in logs
   Solution: Calculate appropriate memory limits
   Example: "Container using 450MB, killed at 512MB. Recommend --memory=1g"

3. DISK SPACE ISSUES:
   Detection: "no space left on device"
   Solution: Identify large log files, old containers, unused volumes
   Example: "Docker using 45GB. Recommend: docker system prune -a"

4. DEPENDENCY FAILURES:
   Detection: Service depends on another that's down
   Solution: Identify dependency chain, restart in correct order
   Example: "App requires DB. DB is down. Restarting DB first."

5. CONFIGURATION ERRORS:
   Detection: Specific error patterns in logs
   Solution: Identify misconfiguration, suggest fix
   Example: "Missing environment variable DATABASE_URL. Should be: DATABASE_URL=postgresql://..."

OUTPUT FORMAT:
🧠 Advanced Diagnostic Report:

Service: [name]
Issue Category: [port conflict/memory/disk/config/dependency]
Root Cause: [detailed technical explanation]

Current State:
[relevant system information]

Proposed Solution:
[specific command or configuration change]

Expected Outcome:
[what will happen after fix is applied]

Risk Assessment: [LOW/MEDIUM/HIGH]
Rollback Plan: [how to undo if needed]

Recommendation: [AUTO-FIX / NEEDS-APPROVAL / MANUAL-INTERVENTION]
```

**Example Interaction - Port Conflict**:
```
Agent: "🧠 Advanced Diagnostic Report:

Service: New Website Container
Issue Category: Port Conflict
Root Cause: Port 8090 is already bound to existing 'website' container

Current State:
- Port 8090: Used by container 'website' (nginx)
- Attempted: docker run -p 8090:80 new-website
- Result: Error 'port is already allocated'

Proposed Solution:
Option 1: Use different port for new container
  docker run -d --name new-website -p 8091:80 nginx
  
Option 2: Stop existing container first
  docker stop website && docker run -d --name new-website -p 8090:80 nginx

Current Resource Availability:
  Available ports: 8091-8099, 9000-9100
  
Expected Outcome (Option 1):
  - Both containers run simultaneously
  - Old site: http://192.168.1.100:8090
  - New site: http://192.168.1.100:8091

Risk Assessment: LOW (no existing services disrupted)
Rollback Plan: docker stop new-website && docker rm new-website

Recommendation: AUTO-FIX with Option 1 (safe, non-disruptive)"
```

**Example Interaction - Memory Optimization**:
```
Agent: "🧠 Advanced Diagnostic Report:

Service: Plex Media Server
Issue Category: Memory Exhaustion (Recurring)
Root Cause: Container repeatedly killed by OOM (Out of Memory)

Current State:
- Container restarts: 7 times in past 24 hours
- Exit code: 137 (OOM Kill)
- Current memory limit: 512MB
- Peak usage before kill: 498MB

Resource Analysis:
[Executed: docker stats --no-stream plex]
- Average usage during transcoding: 850MB
- Baseline (idle): 280MB
- Spike during 4K transcode: 1.2GB

Proposed Solution:
Recreate container with adequate memory allocation:

docker stop plex
docker rm plex
docker run -d \
  --name plex \
  --memory=2g \
  --memory-reservation=1g \
  -p 32400:32400 \
  -v /media/plex:/data \
  plexinc/pms-docker

Configuration Explained:
- --memory=2g: Hard limit (prevents OOM)
- --memory-reservation=1g: Soft limit (performance optimization)
- Allows transcoding without crashes

Expected Outcome:
- No more OOM kills
- Stable transcoding performance
- Container uptime >30 days

Risk Assessment: MEDIUM (requires container recreation)
Rollback Plan: 
  docker stop plex
  [restore from backup configuration]

Recommendation: NEEDS-APPROVAL
This requires downtime and container recreation. Approve to proceed?"
```

**When to Use Stage 4**:
- Complex homelab setups with interdependent services
- Environments experiencing recurring issues
- When you want intelligent optimization suggestions
- Production systems where you value expert-level diagnostics
- Before fully trusting automated fixes (Stage 5)

---

### Stage 5: Human-in-the-Loop

**Capability Overview**: All previous capabilities but ALWAYS requests approval before executing changes

Stage 5 represents the **recommended production configuration** for most users. The agent has full diagnostic and remediation capabilities but respects human authority by requesting approval before making any changes. This balances automation benefits with human oversight.

**Philosophy**: "The agent is the expert consultant; you are the executive decision-maker."

**What It Can Do**:
- Everything from Stages 1-4 (monitor, diagnose, solve complex problems)
- Present complete fix proposals with rationale
- Request approval via Telegram before executing
- Execute only upon explicit confirmation
- Report results after execution
- Learn from approval/rejection patterns (via system prompt refinement)

**What It Cannot Do**:
- Make changes without explicit approval
- Bypass the approval process for "urgent" issues (safety feature)
- Make decisions that weren't approved

**Required Tools**:
- HTTP Request node
- Execute Command node
- Telegram node (for approval requests)
- IF/Switch nodes (for approval logic)

**System Prompt Example**:
```
You are a Level 5 Homelab CTO Agent - the highest level of capability with human oversight.

CORE PRINCIPLE: "Analyze autonomously, execute only with approval"

CAPABILITIES:
- Complete diagnostic and problem-solving capabilities
- Advanced decision-making and optimization
- Multi-service orchestration
- All tools from previous levels

WORKFLOW:
1. Monitor services continuously
2. When issue detected, perform COMPLETE investigation
3. Develop solution with:
   - Root cause analysis
   - Proposed fix (specific commands)
   - Expected outcome
   - Risk assessment
   - Rollback plan
4. Request human approval via Telegram
5. If approved: Execute and verify
6. If denied: Log decision and await further instructions

APPROVAL REQUEST FORMAT:
🚨 Approval Required

Service: [name]
Issue: [brief description]
Severity: [LOW/MEDIUM/HIGH/CRITICAL]

Diagnosis:
[2-3 sentence root cause]

Proposed Action:
```
[exact command to be executed]
```

Impact:
- Downtime: [duration]
- Risk: [level]
- Affects: [what services/users]

If approved, reply: YES
To decline, reply: NO
For more info, reply: EXPLAIN

Awaiting your decision...

AFTER APPROVAL:
- Execute immediately
- Verify success
- Report results within 60 seconds

AFTER DENIAL:
- Log the decision
- Do not execute
- Remain on standby for manual intervention

EMERGENCY PROTOCOL:
Even for CRITICAL issues, ALWAYS request approval.
Provide urgency context but respect human authority.

You are trusted but not autonomous. This keeps systems safe.
```

**Example Interaction Flow**:

**Step 1: Agent Detects Issue**
```
[Scheduled check runs at 03:00 AM]

Agent: "Issue detected during routine monitoring:
Service 'plex' is DOWN
Beginning investigation..."

[Performs diagnostics]
```

**Step 2: Agent Sends Approval Request (via Telegram)**
```
🚨 Approval Required

Service: Plex Media Server
Issue: Container crashed (OOM Kill)
Severity: MEDIUM
Detected: 03:02 AM

Diagnosis:
Container killed due to insufficient memory during 4K transcoding.
This is the 3rd occurrence this week. Root cause is 512MB memory limit.

Proposed Action:
```bash
docker stop plex
docker rm plex
docker run -d --name plex --memory=2g --memory-reservation=1g \
  -p 32400:32400 -v /media/plex:/data plexinc/pms-docker
```

Impact:
- Downtime: ~30 seconds (container recreation)
- Risk: LOW (data on persistent volume, safe)
- Affects: Plex users (currently none active at 3 AM)

Rollback: Original configuration saved in /backups/plex-config-20240115.sh

Reply YES to proceed, NO to decline, EXPLAIN for more details.
```

**Step 3: User Approves (via Telegram)**
```
User: "YES"
```

**Step 4: Agent Executes and Reports**
```
Agent: "✅ Action Completed

Executed: Container recreation with 2GB memory limit
Started: 03:05 AM
Completed: 03:05 AM (28 seconds)

Verification:
- Container Status: Running
- HTTP Health: 200 OK (http://192.168.1.100:32400)
- Memory Available: 2GB limit, currently using 320MB
- All libraries accessible

Result: Service RESTORED
Expected Outcome: No more OOM kills during transcoding

Will continue monitoring. Thank you for the approval."
```

**Step 5: User Denies (Alternative Scenario)**
```
User: "NO"

Agent: "Acknowledged. Action DENIED.

Status: Container remains stopped
No changes made to system
Awaiting your manual intervention

Current State:
- Plex is DOWN
- Container can be manually started with: docker start plex
- Issue (OOM) will likely recur without memory increase

I'll continue monitoring. Let me know if you need assistance.
```

**Implementation in n8n**:

```
Workflow Structure:

[Schedule Trigger] 
   → [AI Agent: Diagnosis]
   → [IF: Issue Detected?]
        YES → [AI Agent: Prepare Fix Proposal]
              → [Telegram: Send Approval Request]
              → [Webhook or Telegram Listener: Wait for Response]
              → [IF: Response = "YES"]
                   YES → [AI Agent: Execute Fix]
                         → [Telegram: Send Success Report]
                   NO → [Telegram: Acknowledge Denial]
        NO → [End]
```

**Telegram Approval Configuration**:
```javascript
// In Telegram node - Send Message
{
  "chat_id": "{{ $env.TELEGRAM_CHAT_ID }}",
  "text": "{{ $json.approval_request }}",
  "reply_markup": {
    "keyboard": [
      [{"text": "YES"}, {"text": "NO"}],
      [{"text": "EXPLAIN"}]
    ],
    "one_time_keyboard": true
  }
}
```

**Benefits of Stage 5**:
- Full automation capabilities with human oversight
- Sleep peacefully knowing nothing happens without approval
- Build confidence over time by seeing agent decisions
- Educational: Learn what issues occur and how to solve them
- Audit trail: Every action is logged and approved
- Flexible: Approve from anywhere via Telegram

**When to Use Stage 5**:
- **Production environments** (highly recommended)
- Services with external users or customers
- Compliance environments requiring human authorization
- When building trust in the agent system
- High-value infrastructure (databases, storage, networking)
- As your default configuration

**This is the recommended stage for most users.** It provides all the benefits of intelligent automation while maintaining human control and preventing runaway automation scenarios.

---

### Progression Recommendation

**Week 1-2**: Stage 1 (Basic Monitor)
- Get comfortable with n8n and AI agents
- Understand your infrastructure's normal behavior
- Build confidence in the system

**Week 3-4**: Stage 2 (Smart Investigator)
- Add diagnostic capabilities
- Study the logs and patterns
- Learn what typically fails and why

**Week 5-6**: Stage 3 (The Fixer) - Test Environment Only
- Enable automatic fixes in isolated environment
- Monitor for unexpected behaviors
- Refine safety constraints

**Week 7-8**: Stage 4 (Creative Problem Solver)
- Add complex problem-solving
- Handle resource conflicts
- Optimize configurations

**Week 9+**: Stage 5 (Human-in-the-Loop) - Production
- Deploy to production with approval requirements
- Enjoy 24/7 monitoring with control
- Gradually expand scope as trust builds

**Never skip directly to Stage 3, 4, or 5 in production.** Understanding each stage ensures you can troubleshoot issues and maintain confidence in your system.

---

## Chapter 5 – Automation Setup

Transform your manual agent into a 24/7 autonomous monitoring system with scheduled execution, structured output, and intelligent notifications. This chapter covers scheduling, JSON standardization, and complete Telegram integration including BotFather setup.

### Section 5.1: Scheduled Monitoring

Moving from manual testing to automated monitoring requires replacing your Manual Trigger with a Schedule Trigger and implementing proper error handling.

#### Configuring the Schedule Trigger

**Step 1: Remove Manual Trigger**
1. In your workflow, select the Manual Trigger node
2. Delete it (or keep it for testing in a separate branch)

**Step 2: Add Schedule Trigger**
1. Click the **"+"** button to add a new node
2. Search for **"Schedule Trigger"**
3. Add it to your workflow
4. Connect it to your AI Agent chain

**Step 3: Configure Timing**

For production monitoring, recommended intervals:

```
Critical Services (databases, core infrastructure):
- Interval: Every 2 minutes
- Schedule: "*/2 * * * *" (cron format)

Important Services (web apps, media servers):
- Interval: Every 5 minutes  
- Schedule: "*/5 * * * *"

Non-Critical Services (development, testing):
- Interval: Every 15-30 minutes
- Schedule: "*/15 * * * *" or "*/30 * * * *"
```

**Example Configuration**:
```
Trigger Node: Schedule Trigger
Trigger Interval: Every 5 minutes
Cron Expression: */5 * * * *
```

**Step 4: Test Scheduled Execution**

1. Save and activate the workflow
2. Wait for the next scheduled interval
3. Check execution history (View → Executions)
4. Verify the agent runs automatically

#### Preventing Overlap and Race Conditions

When running on a schedule, prevent multiple executions from conflicting:

**Workflow Settings**:
```
Settings → Workflow:
- Execution Order: "v1" (ensures sequential execution)
- Timeout: 300 seconds (prevents hanging workflows)
- Error Workflow: [optional - trigger if workflow fails]
```

**In AI Agent Settings**:
```
Max Iterations: 10 (prevents infinite loops)
Timeout: 120 seconds (per agent invocation)
```

---

### Section 5.2: Structured JSON Output

Consistency is key for automation. Teach your agent to return standardized JSON that downstream nodes can process reliably.

#### Why JSON Matters

**Without JSON** (free-form text):
```
Agent: "The website seems to be down. I checked and the container isn't running. Maybe restart it?"
```
↓ Hard to parse, trigger notifications, or make decisions

**With JSON** (structured):
```json
{
  "status": "down",
  "service": "website",
  "issue": "container_stopped",
  "severity": "high",
  "proposed_fix": "docker restart website",
  "requires_approval": true
}
```
↓ Easy to route, trigger alerts, and automate responses

#### Standard JSON Schema

Define a consistent structure for your agents:

```json
{
  "timestamp": "2024-01-15T14:23:45Z",
  "service": {
    "name": "website",
    "url": "http://192.168.1.100:8090",
    "type": "web"
  },
  "status": "down",
  "checks_performed": [
    {
      "type": "http",
      "result": "failed",
      "error": "Connection refused"
    },
    {
      "type": "container",
      "result": "stopped",
      "exit_code": 137
    }
  ],
  "diagnosis": {
    "root_cause": "Out of memory (OOM) kill",
    "confidence": "high",
    "evidence": [
      "Exit code 137 indicates OOM",
      "Logs show memory exhaustion before crash"
    ]
  },
  "proposed_action": {
    "type": "restart",
    "command": "docker restart website",
    "requires_approval": true,
    "risk_level": "low",
    "estimated_downtime": "10 seconds"
  },
  "severity": "medium",
  "notification_sent": false
}
```

#### Teaching Your Agent to Output JSON

**System Prompt Addition**:
```
OUTPUT FORMAT REQUIREMENT:

You MUST respond with valid JSON following this exact schema:

{
  "timestamp": "[ISO 8601 timestamp]",
  "service": {
    "name": "[service name]",
    "url": "[service URL if applicable]",
    "type": "[web/database/container/vm]"
  },
  "status": "[up/down/degraded/unknown]",
  "checks_performed": [
    {
      "type": "[http/container/process/disk]",
      "result": "[success/failed]",
      "details": "[any relevant details]"
    }
  ],
  "diagnosis": {
    "root_cause": "[your analysis]",
    "confidence": "[high/medium/low]",
    "evidence": ["[supporting fact 1]", "[supporting fact 2]"]
  },
  "proposed_action": {
    "type": "[restart/none/manual/investigate]",
    "command": "[exact command if applicable]",
    "requires_approval": true/false,
    "risk_level": "[low/medium/high]",
    "estimated_downtime": "[duration]"
  },
  "severity": "[low/medium/high/critical]",
  "notification_sent": false
}

CRITICAL: 
- Output ONLY valid JSON, no additional text
- All string values must be properly escaped
- Include all fields even if null
- Use lowercase for enum values (status, severity, etc.)
```

#### Parsing Agent JSON in n8n

After your AI Agent node, add a **Code node** to parse and validate:

```javascript
// Node: Parse Agent Response
const agentOutput = $input.first().json.output;

// Parse JSON from agent response
let report;
try {
  // Extract JSON if agent included extra text
  const jsonMatch = agentOutput.match(/\{[\s\S]*\}/);
  if (jsonMatch) {
    report = JSON.parse(jsonMatch[0]);
  } else {
    throw new Error("No JSON found in agent response");
  }
} catch (error) {
  // Fallback if parsing fails
  report = {
    status: "error",
    service: { name: "unknown" },
    diagnosis: { root_cause: "Failed to parse agent output" },
    severity: "low",
    notification_sent: false,
    raw_output: agentOutput
  };
}

// Validate required fields
report.timestamp = report.timestamp || new Date().toISOString();
report.notification_sent = false; // Will be updated after notification

return { json: report };
```

---

### Section 5.3: Telegram Integration

Telegram serves as your command center: receiving alerts, sending approvals, and providing status updates. This section covers complete setup from scratch.

#### Part A: Creating Your Telegram Bot

**Step 1: Start Conversation with BotFather**

1. Open Telegram app (mobile or desktop)
2. Search for **@BotFather** (verified bot with blue checkmark)
3. Start a conversation: `/start`

**Step 2: Create New Bot**

Send command:
```
/newbot
```

BotFather responds:
```
Alright, a new bot. How are we going to call it? Please choose a name for your bot.
```

**Step 3: Name Your Bot**

Choose a display name (can contain spaces):
```
Homelab CTO Agent
```

**Step 4: Choose Username**

Must end in 'bot' and be unique:
```
homelab_cto_agent_bot
```
(Try variations if taken: `homelab_cto_2024_bot`, `your_name_homelab_bot`, etc.)

**Step 5: Receive Bot Token**

BotFather provides your token:
```
Done! Congratulations on your new bot. You will find it at t.me/homelab_cto_agent_bot

Use this token to access the HTTP API:
7234567890:AAHfG7Xm2qZpYq9_JxEn6KqQx7rY3MpLv8w

Keep your token secure and store it safely, it can be used by anyone to control your bot.
```

**⚠️ CRITICAL**: This token is like a password. Never share it, commit it to git, or post it publicly.

**Step 6: Store Token Securely**

In n8n:
1. Go to **Credentials → New**
2. Select **"Telegram API"** credential type
3. Enter:
   - **Credential Name**: "Homelab CTO Bot"
   - **Access Token**: `[paste your token]`
4. Save

#### Part B: Getting Your Chat ID

For the bot to send you messages, it needs your Chat ID.

**Step 1: Start Conversation with Your Bot**

1. In Telegram, search for your bot's username (`@homelab_cto_agent_bot`)
2. Click **Start** or send any message like "Hello"

**Step 2: Get Your Chat ID**

**Method 1 - Using n8n Workflow**:

Create a temporary workflow:
```
[Webhook Trigger]
  → [Telegram Trigger: On Message]
      → [Set: Extract Chat ID]
```

Configure:
- **Telegram Trigger**: Select your bot credential
- **Updates**: "message"

When you send a message to your bot, the workflow captures it and displays the chat ID in the execution data.

**Method 2 - Using API Call**:

Open browser and navigate to:
```
https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates
```

Replace `<YOUR_BOT_TOKEN>` with your actual token.

Look for JSON response:
```json
{
  "ok": true,
  "result": [
    {
      "update_id": 123456789,
      "message": {
        "message_id": 1,
        "from": {
          "id": 987654321,  ← This is your Chat ID
          "is_bot": false,
          "first_name": "Your Name"
        },
        "chat": {
          "id": 987654321,  ← Chat ID (same as user ID for private chats)
          "type": "private"
        },
        "text": "Hello"
      }
    }
  ]
}
```

**Step 3: Store Chat ID**

Save it in n8n environment variables:
1. In n8n settings, go to **Settings → Environment Variables** (if available)
2. Or store directly in workflow using **Set** node at the beginning:

```javascript
{
  "TELEGRAM_CHAT_ID": "987654321"
}
```

#### Part C: Workflow Integration

Now connect your agent to Telegram for notifications.

**Notification Workflow Structure**:

```
[Schedule Trigger - Every 5 min]
  → [AI Agent - Monitoring]
  → [Code - Parse JSON]
  → [IF - Issue Detected?]
       YES → [Telegram - Send Alert]
             → [IF - Requires Approval?]
                  YES → [Telegram - Wait for Response]
                        → [Switch - Handle Response]
                             YES → [AI Agent - Execute Fix]
                                   → [Telegram - Confirm Execution]
                             NO  → [Telegram - Log Denial]
                             EXPLAIN → [AI Agent - Provide Details]
                                       → [Telegram - Send Explanation]
                  NO  → [End]
       NO  → [End - All Clear]
```

**Configure Telegram Nodes**:

**Node 1: Alert Notification**
```
Node: Telegram
Action: Send Message
Credential: Homelab CTO Bot
Chat ID: {{ $env.TELEGRAM_CHAT_ID }} or hardcode your ID
Message:
```

```
🚨 Service Issue Detected

Service: {{ $json.service.name }}
Status: {{ $json.status }}
Severity: {{ $json.severity }}

Issue:
{{ $json.diagnosis.root_cause }}

Time: {{ $json.timestamp }}

Checking if action needed...
```

**Node 2: Approval Request** (if needed)
```
Message:
```

```
⚠️ Approval Required

Service: {{ $json.service.name }}
Issue: {{ $json.diagnosis.root_cause }}

Proposed Fix:
`{{ $json.proposed_action.command }}`

Risk: {{ $json.proposed_action.risk_level }}
Downtime: {{ $json.proposed_action.estimated_downtime }}

Reply:
YES - Execute fix
NO - Skip action
EXPLAIN - More details
```

```
Reply Markup: (makes clickable buttons)
{
  "keyboard": [
    [{"text": "YES"}, {"text": "NO"}],
    [{"text": "EXPLAIN"}]
  ],
  "one_time_keyboard": true,
  "resize_keyboard": true
}
```

#### Part D: Handling User Responses

To wait for and process user responses, use Telegram Trigger in a separate workflow or webhook pattern.

**Approach 1: Separate Approval Workflow** (Recommended)

Main Workflow:
- Detects issues
- Sends approval request with unique ID
- Stores pending approval in temporary storage

Approval Workflow:
```
[Telegram Trigger - On Message]
  → [IF - Is Response to Approval?]
       YES → [Switch - Response Type]
              YES → [Execute - Trigger Main Workflow with Execute]
              NO  → [Update - Mark as Denied]
              EXPLAIN → [Send - Detailed Explanation]
       NO  → [Ignore or handle as chat message]
```

**Approach 2: Webhook Pattern** (Advanced)

Use n8n's webhook node to create a callback URL:
1. Approval request includes unique token
2. User clicks link or button with token
3. Webhook receives response
4. Continues execution

#### Part E: Notification Logic

Implement smart notifications to avoid alert fatigue.

**Conditions for Sending Notifications**:

```javascript
// In IF node after AI Agent
const report = $json;

// Send notification if:
const shouldNotify = 
  report.status === 'down' ||                    // Service is down
  report.severity === 'high' ||                  // High severity issue
  report.severity === 'critical' ||              // Critical issue
  report.proposed_action.requires_approval;      // Needs approval

return shouldNotify;
```

**Rate Limiting to Prevent Spam**:

```javascript
// Store last notification time in workflow static data
const now = Date.now();
const lastNotification = $('WorkflowStaticData').first().json.last_notification || 0;
const minIntervalMs = 15 * 60 * 1000; // 15 minutes

if (now - lastNotification < minIntervalMs && report.severity !== 'critical') {
  // Skip notification unless critical
  return false;
}

// Update last notification time
$('WorkflowStaticData').first().json.last_notification = now;
return true;
```

**Different Notification Levels**:

```javascript
// Customize message based on severity
let emoji, urgency;

switch (report.severity) {
  case 'critical':
    emoji = '🔴';
    urgency = 'CRITICAL - Immediate attention required';
    break;
  case 'high':
    emoji = '🟠';
    urgency = 'HIGH - Action needed soon';
    break;
  case 'medium':
    emoji = '🟡';
    urgency = 'MEDIUM - Monitor closely';
    break;
  case 'low':
    emoji = '🟢';
    urgency = 'LOW - Informational';
    break;
  default:
    emoji = 'ℹ️';
    urgency = 'Status Update';
}

return {
  json: {
    message: `${emoji} ${urgency}\n\n${report.diagnosis.root_cause}`,
    severity: report.severity
  }
};
```

#### Complete Example Workflow

Putting it all together:

```
┌─────────────────────────────────────────────────────────────┐
│  [Schedule Trigger: */5 * * * *]                            │
└───────────────────┬─────────────────────────────────────────┘
                    │
┌───────────────────▼─────────────────────────────────────────┐
│  [AI Agent: Monitor Services]                               │
│  - Check health                                             │
│  - Return JSON report                                       │
└───────────────────┬─────────────────────────────────────────┘
                    │
┌───────────────────▼─────────────────────────────────────────┐
│  [Code: Parse JSON Response]                                │
│  - Extract structured data                                  │
│  - Validate fields                                          │
└───────────────────┬─────────────────────────────────────────┘
                    │
┌───────────────────▼─────────────────────────────────────────┐
│  [IF: Issue Detected?]                                      │
│  Condition: status != 'up'                                  │
└─────┬──────────────────────────────────────────────┬────────┘
     YES                                             NO
      │                                              │
┌─────▼──────────────────────────────────┐    ┌─────▼─────┐
│  [Telegram: Send Alert]                │    │  [End]    │
│  Message: Issue details                │    └───────────┘
└─────┬──────────────────────────────────┘
      │
┌─────▼──────────────────────────────────┐
│  [IF: Requires Approval?]              │
│  Condition: proposed_action.requires_  │
│              approval == true          │
└─────┬──────────────────────┬───────────┘
     YES                    NO
      │                     │
┌─────▼───────────────┐  ┌──▼──────────────────────┐
│  [Telegram: Send   │  │  [AI Agent: Auto-fix]   │
│   Approval Request] │  │  (if Stage 3 enabled)   │
└─────┬───────────────┘  └──┬──────────────────────┘
      │                     │
      │                  ┌──▼──────────────────────┐
      │                  │  [Telegram: Confirm]    │
      │                  └─────────────────────────┘
      │
┌─────▼───────────────┐
│  [Wait for Response]│
│  (Separate workflow)│
└─────────────────────┘
```

---

### Section 5.4: Testing Your Automated System

Before trusting automated monitoring, thoroughly test all scenarios.

**Test Checklist**:

```
[ ] Schedule runs at correct intervals
[ ] Agent successfully monitors services
[ ] JSON output is valid and complete
[ ] Notifications arrive on Telegram
[ ] Approval requests include all necessary information
[ ] YES responses trigger correct actions
[ ] NO responses are logged appropriately
[ ] EXPLAIN requests provide detailed information
[ ] Critical alerts bypass rate limiting
[ ] Non-critical alerts respect quiet hours (if configured)
[ ] All actions are logged for audit
```

**Simulate Failure Scenarios**:

```bash
# Test 1: Service down
docker stop website
# Wait for next schedule interval
# Verify: Telegram alert received

# Test 2: Approve restart
# Respond with "YES" in Telegram
# Verify: Container restarted, success notification received

# Test 3: Deny restart
docker stop website
# Respond with "NO" in Telegram
# Verify: No action taken, denial logged

# Test 4: Request explanation
# Respond with "EXPLAIN" in Telegram
# Verify: Detailed diagnostic information received
```

---

Your automation system is now complete. In Chapter 6, we'll integrate specific services like Proxmox, UniFi, and NAS systems.

---

## 🔗 Service Integrations

### Uptime Kuma Integration
Feed monitoring data into your agent for uptime alerts:
- Pull monitoring status via API
- Trigger workflows on downtime
- Correlate with other service metrics

### UniFi Network Monitoring
Monitor network health and client connectivity:
- Check connected clients
- Monitor bandwidth utilization
- Track Wi-Fi health metrics
- Alert on network issues

### Proxmox Integration
Manage VMs and containers across your cluster:
- List nodes and their status
- Monitor VM/container health
- Check resource utilization
- Use SSH subworkflow for advanced operations

**Example**: Create a subworkflow for Proxmox SSH commands

### NAS (ZimaCube) Monitoring
Keep your storage healthy:
- Monitor disk health (SMART data)
- Check RAID status
- Review storage logs
- Alert on capacity issues

**Recommended**: Use read-only checks for safety

### Plex Media Server
Ensure your media server stays online:
- Monitor via HTTP health checks
- Restart container if needed
- Check transcoding status
- Monitor resource usage

---

## 🧠 Advanced Features

### Human Approval Loop

Implement a Telegram-based approval system:

1. **Setup Telegram Bot**
   - Create bot via @BotFather
   - Get bot token
   - Obtain your Chat ID

2. **Workflow Configuration**
   - Agent proposes fix
   - Send approval request to Telegram
   - Wait for YES/NO response
   - Execute only on approval

**Example Flow**:
```
Agent Detects Issue → Propose Fix → Send to Telegram → Wait for Approval → Execute or Skip
```

### God-Mode Prompt (⚠️ Use with Caution!)

Allow autonomous fixes with explicit reporting:

**Example God-Mode System Prompt**:
```
You are an autonomous homelab CTO agent. You can:
1. Diagnose issues across all services
2. Apply fixes automatically
3. MUST report every action in JSON format
4. MUST log all changes made
5. Escalate critical issues to human

Always provide detailed reasoning for each action.
```

**Safety Requirements**:
- Enable detailed logging
- Set up action limits
- Configure rollback capabilities
- Test thoroughly in isolated environment first

### Agent Collaboration

Assign specialized roles for complex problem-solving:

#### Network Admin Agent
**Responsibilities**:
- Monitor network performance
- Manage UniFi devices
- Troubleshoot connectivity issues
- Optimize bandwidth allocation

#### Storage Expert Agent
**Responsibilities**:
- Monitor NAS health
- Manage disk space
- Handle RAID issues
- Optimize storage allocation

#### Linux Engineer Agent
**Responsibilities**:
- Manage Docker containers
- Handle SSH operations
- System resource monitoring
- Log analysis and debugging

#### Security Officer Agent
**Responsibilities**:
- Monitor access logs
- Track failed login attempts
- Update security patches
- Firewall rule management

**Collaboration Model**:
- Shared knowledge base for documentation
- Cross-agent consultation for complex issues
- Escalation path for critical problems
- Unified reporting dashboard

---

## 👥 Complete IT Team Agent Structure

Build a comprehensive AI-powered IT team:

### Core Agent Roles

1. **🔱 Vishnu - CTO Agent (The Preserver)**
   - **Qualities**: Maintenance, stability, balance
   - Oversees all operations
   - Prioritizes issues
   - Coordinates agent collaboration
   - Makes strategic decisions
   - **Why**: Vishnu maintains cosmic order and balance, perfect for a CTO agent that preserves system stability

2. **⚙️ Brahma - Network Administrator (The Creator)**
   - **Qualities**: Creation, architecture, design
   - Monitors network infrastructure
   - Manages switches, routers, access points
   - Handles VLAN configurations
   - Troubleshoots connectivity
   - **Why**: Brahma creates the universe, ideal for agents that build network infrastructure

3. **🔱 Vishnu - System Administrator (The Preserver)**
   - **Qualities**: Maintenance, stability, balance
   - Manages servers and VMs
   - Handles container orchestration
   - Monitors system resources
   - Performs backups
   - **Why**: Maintains system stability and ensures balanced resource allocation

4. **⚙️ Brahma - Storage Specialist (The Creator)**
   - **Qualities**: Creation, architecture, design
   - Monitors disk arrays
   - Manages NAS systems
   - Handles RAID configurations
   - Optimizes storage performance
   - **Why**: Creates and architects storage solutions

5. **🌸 Saraswati - Database Administrator (The Knowledge Bearer)**
   - **Qualities**: Wisdom, learning, documentation
   - Monitors database health
   - Optimizes query performance
   - Manages backups and recovery
   - Handles migrations
   - **Why**: Saraswati represents knowledge and learning, perfect for managing data systems

6. **🏔️ Ganesha - Security Engineer (The Obstacle Remover)**
   - **Qualities**: Problem-solving, removing blockers
   - Monitors security events
   - Manages firewall rules
   - Handles certificate renewals
   - Conducts security audits
   - **Why**: Ganesha removes obstacles, perfect for removing security threats and blockers

7. **🔥 Shiva - DevOps Engineer (The Transformer)**
   - **Qualities**: Destruction (of bugs), recreation, transformation
   - Manages CI/CD pipelines
   - Handles deployments
   - Monitors application performance
   - Automates workflows
   - **Why**: Shiva represents change and regeneration, ideal for agents that rebuild and improve systems

8. **⚡ Hanuman - Helpdesk Agent (The Devoted Servant)**
   - **Qualities**: Strength, dedication, problem-solving
   - Receives user tickets
   - Provides first-line support
   - Routes complex issues to specialists
   - Maintains knowledge base
   - **Why**: Hanuman's unwavering dedication and strength make him perfect for support agents

### Team Collaboration Features

- **Shared Knowledge Base**: Centralized documentation accessible by all agents
- **Helpdesk System**: User-submitted tickets with intelligent routing
- **Agent Handoffs**: Complex problems automatically escalated to specialists
- **Collaborative Problem Solving**: Multiple agents work together on critical issues
- **Learning System**: Agents improve based on past resolutions

---

## 🩺 Troubleshooting

### Common Issues and Solutions

#### n8n Workflow Errors
**Problem**: Variable mapping errors (chatId, prompt)
- **Solution**: Check node connections and variable names
- Verify data structure between nodes
- Use "Execute Node" to test individual steps

#### Too Many Tool Calls
**Problem**: Agent exceeds iteration limit
- **Solution**: Increase max iterations in agent settings
- Simplify the task scope
- Break complex tasks into smaller workflows

#### Telegram Not Responding
**Problem**: Messages not being sent/received
- **Solution**: Verify Chat ID is correct
- Confirm bot token is valid
- Check bot has permission to send messages
- Test with direct API call

#### SSH Connection Failures
**Problem**: Cannot execute remote commands
- **Solution**: Verify SSH key configuration
- Check subworkflow command mapping
- Ensure proper network connectivity
- Test SSH manually first

#### Agent Not Making Decisions
**Problem**: Agent seems stuck or unresponsive
- **Solution**: Review system prompt clarity
- Check LLM API key and credits
- Increase temperature for more creative responses
- Verify tool configurations

#### Docker Permission Issues
**Problem**: Cannot execute Docker commands
- **Solution**: Ensure n8n has Docker access
- Add n8n user to docker group
- Check socket permissions
- Use sudo if necessary (with caution)

---

## ✅ Best Practices

### Development Workflow
1. **Start Simple**: Begin with basic monitoring before adding complexity
2. **Test Thoroughly**: Always test with demo containers before production
3. **Incremental Deployment**: Add one capability at a time
4. **Document Everything**: Keep detailed notes of each integration

### Security Considerations
1. **Always Require Approval**: For destructive commands (restarts, deletions)
2. **Use Read-Only First**: Start with monitoring before allowing changes
3. **Secure Remote Access**: Use VPN or Twingate for external access
4. **Rotate Credentials**: Regularly update API keys and tokens
5. **Audit Logs**: Keep comprehensive logs of all agent actions

### Performance Optimization
1. **Efficient Polling**: Don't over-poll services (5-minute intervals are usually sufficient)
2. **Caching**: Cache service status to reduce API calls
3. **Conditional Execution**: Only trigger actions when status changes
4. **Resource Limits**: Set memory and CPU limits for agent processes

### Reliability Guidelines
1. **Fallback Mechanisms**: Have backup notification channels
2. **Health Checks**: Monitor the monitoring system itself
3. **Graceful Degradation**: Continue partial operations if some services fail
4. **Recovery Procedures**: Document manual recovery steps

### Team Collaboration
1. **Clear Role Assignment**: Each agent should have well-defined responsibilities
2. **Escalation Paths**: Define when to escalate between agents
3. **Knowledge Sharing**: Maintain shared documentation
4. **Version Control**: Track agent prompt and configuration changes

---

## 📚 Additional Resources

### Example Workflows
(Coming soon - workflow JSON exports for common scenarios)

### Community Examples
- Multi-agent orchestration patterns
- Advanced Telegram integration examples
- Service-specific monitoring workflows

### Integration Guides
- Detailed setup for each supported service
- API authentication examples
- Troubleshooting specific integrations

---

## 📌 Support & Contact

### Getting Help

For questions, issues, or contributions:

- **Email**: riteshrana36@gmail.com
- **GitHub**: [@ambicuity](https://github.com/ambicuity)
- **Website**: [www.riteshrana.engineer](https://www.riteshrana.engineer)

### Contributing

Contributions are welcome! Please feel free to:
- Report issues
- Suggest improvements
- Share your agent configurations
- Submit pull requests

### Acknowledgments

Special thanks to the n8n community and all open-source contributors who make projects like this possible.

---

## 📄 License

This project is provided as-is for educational and homelab purposes. Please ensure compliance with all service terms of use and API limitations.

---

**Built with ❤️ for homelabbers and self-hosted enthusiasts**

*May your services always be up, your logs always be clear, and your agents always make wise decisions! 🚀*