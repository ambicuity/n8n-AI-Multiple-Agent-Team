# n8n AI Multiple Agent Team — Homelab CTO Setup Guide

> **Author**: Ritesh Rana ([@ambicuity](https://github.com/ambicuity))  
> **Contact**: riteshrana36@gmail.com  
> **Website**: [www.riteshrana.engineer](https://www.riteshrana.engineer)

---

## 📖 Overview

This project documents the setup of an **AI-powered multi-agent system** built with **n8n** to run and manage a **homelab/business network** like a true **CTO**.

This guide contains all the commands, prompts, and configurations shown in the guide for setting up n8n AI Agents Team, an intelligent AI agent system that can:

- **Monitor** uptime & performance across all your services
- **Troubleshoot** issues automatically using intelligent diagnostics
- **Request approval** before applying fixes (human-in-the-loop)
- **Save time, money, and stress** by leveraging your existing infrastructure
- **Collaborate** through specialized agent roles for complex problems

The system integrates with your already running services such as:
- Uptime Kuma (monitoring)
- Proxmox (virtualization)
- UniFi Controller (network management)
- Plex (media server)
- NAS systems (e.g., ZimaCube)
- And more...

> Inspired by modern AI agent frameworks, but specifically adapted for full **homelab orchestration** and IT operations management.

---

## 🛠️ Prerequisites

Before getting started, ensure you have the following:

### Required
- **n8n instance** (self-hosted or cloud)
- **Docker** installed on homelab server(s)
- **OpenAI API key** (or other compatible LLM provider)
- **Telegram account** + Bot token (for alerts/approvals)

### Service Access
Access to your existing services:
- **Uptime Kuma** - For monitoring integration
- **UniFi Controller** - Network device management
- **Proxmox** - VM/Container orchestration
- **NAS** (e.g., ZimaCube) - Storage management
- **Plex** - Media server monitoring

### Optional but Recommended
- Secure access via **VPN** or **Twingate**
- SSH access to homelab servers
- Basic understanding of Docker and n8n workflows

---

## ⚡ Initial Setup

### 1. Demo Website (Testing Agent Monitoring)

Start by creating a simple test website to validate your monitoring setup:

```bash
# Run a simple nginx container
docker run -d --name website -p 8090:80 nginx

# Add custom content
docker exec website sh -c 'echo "<h1>Homelab CTO Agent</h1>" > /usr/share/nginx/html/index.html'
```

**Test the deployment:**
```bash
curl http://YOUR_SERVER_IP:8090
```

You should see the "Homelab CTO Agent" heading.

### 2. n8n Workflow Basics

#### Create Your First Agent Workflow

1. **Add Manual Trigger**
   - Open n8n workflow editor
   - Add a "Manual Trigger" node to start

2. **Add AI Agent Node**
   - Search for "AI Agent" in the node menu
   - Add it to your workflow

3. **Configure the Agent**
   - **Model**: OpenAI GPT-4o-mini (or compatible)
   - **Memory**: Simple Session Memory
   - **System Prompt**: Define the agent's role (see Agent Evolution section)

4. **Connect HTTP Request Tool**
   - Add HTTP Request node as a tool
   - Configure it to check website status
   - Connect to AI Agent

---

## 🤖 Agent Evolution Stages

Build your agent capabilities progressively:

### Stage 1: Basic Monitor
**Capability**: Check uptime via HTTP tool
- Monitor website availability
- Return simple up/down status
- Basic health checks

**Example System Prompt**:
```
You are a homelab monitoring agent. Check if services are running and report their status.
```

### Stage 2: Smart Investigator
**Capability**: Use Docker + logs to diagnose issues
- List running containers
- Read container logs
- Identify common error patterns
- Provide diagnostic insights

**Tools Required**:
- Docker CLI tool
- Log reading capabilities

### Stage 3: The Fixer
**Capability**: Restart containers if down
- Detect failed services
- Restart Docker containers
- Verify service recovery
- Report actions taken

**⚠️ Note**: Always test with demo containers first!

### Stage 4: Creative Problem Solver
**Capability**: Resolve conflicts (ports, memory, disk)
- Identify resource conflicts
- Suggest port remapping
- Detect memory/disk issues
- Provide optimization recommendations

### Stage 5: Human-in-the-Loop
**Capability**: Always ask before applying fixes
- Present diagnosis and proposed fix
- Request approval via Telegram
- Execute only after confirmation
- Report results to user

**This is the recommended production configuration!**

---

## 🔔 Automation Setup

### Scheduled Monitoring

Configure automatic checks at regular intervals:

1. **Add Schedule Trigger**
   - Replace Manual Trigger with Schedule Trigger
   - Set interval: Every 5 minutes (or as needed)

2. **Structured JSON Output**
   - Configure agent to return consistent JSON format
   - Enable easier workflow decisions based on output

**Example JSON Structure**:
```json
{
  "status": "down",
  "service": "website",
  "issue": "Container stopped",
  "proposedFix": "docker restart website",
  "severity": "high"
}
```

3. **Telegram Integration**
   - Add Telegram node for notifications
   - Configure for:
     - Downtime alerts
     - Fix confirmations
     - Approval requests
     - Status reports

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

1. **CTO Agent (Coordinator)**
   - Oversees all operations
   - Prioritizes issues
   - Coordinates agent collaboration
   - Makes strategic decisions

2. **Network Administrator**
   - Monitors network infrastructure
   - Manages switches, routers, access points
   - Handles VLAN configurations
   - Troubleshoots connectivity

3. **System Administrator**
   - Manages servers and VMs
   - Handles container orchestration
   - Monitors system resources
   - Performs backups

4. **Storage Specialist**
   - Monitors disk arrays
   - Manages NAS systems
   - Handles RAID configurations
   - Optimizes storage performance

5. **Database Administrator**
   - Monitors database health
   - Optimizes query performance
   - Manages backups and recovery
   - Handles migrations

6. **Security Engineer**
   - Monitors security events
   - Manages firewall rules
   - Handles certificate renewals
   - Conducts security audits

7. **DevOps Engineer**
   - Manages CI/CD pipelines
   - Handles deployments
   - Monitors application performance
   - Automates workflows

8. **Helpdesk Agent**
   - Receives user tickets
   - Provides first-line support
   - Routes complex issues to specialists
   - Maintains knowledge base

### Team Collaboration Features

- **Shared Knowledge Base**: Centralized documentation accessible by all agents
- **Helpdesk System**: User-submitted tickets with intelligent routing
- **Agent Handoffs**: Complex problems automatically escalated to specialists
- **Collaborative Problem Solving**: Multiple agents work together on critical issues
- **Learning System**: Agents improve based on past resolutions

---

## 🕉️ The Divine CTO - Agent Naming Philosophy

### Why Choose a Hindu Deity Name?

In Hindu philosophy, different deities represent specific qualities essential for managing complex systems:

#### Recommended Deity Names & Their Significance

**🔱 Vishnu - The Preserver**
- **Qualities**: Maintenance, stability, balance
- **Best For**: Production environment management
- **Why**: Vishnu maintains cosmic order and balance, perfect for a CTO agent that preserves system stability

**🔥 Shiva - The Transformer**
- **Qualities**: Destruction (of bugs), recreation, transformation
- **Best For**: Development and refactoring tasks
- **Why**: Shiva represents change and regeneration, ideal for agents that rebuild and improve systems

**⚡ Hanuman - The Devoted Servant**
- **Qualities**: Strength, dedication, problem-solving
- **Best For**: Helpdesk and support roles
- **Why**: Hanuman's unwavering dedication and strength make him perfect for support agents

**🌸 Saraswati - The Knowledge Bearer**
- **Qualities**: Wisdom, learning, documentation
- **Best For**: Knowledge base and training systems
- **Why**: Saraswati represents knowledge and learning, perfect for documentation agents

**⚙️ Brahma - The Creator**
- **Qualities**: Creation, architecture, design
- **Best For**: Infrastructure provisioning and setup
- **Why**: Brahma creates the universe, ideal for agents that build new systems

**🏔️ Ganesha - The Obstacle Remover**
- **Qualities**: Problem-solving, removing blockers
- **Best For**: Troubleshooting and debugging
- **Why**: Ganesha removes obstacles, perfect for agents that resolve issues

### Implementation Example

```yaml
Agent_Name: Vishnu
Role: Homelab CTO
Mantra: "Preservation of system harmony through intelligent automation"
Primary_Focus: Maintaining uptime and balance across all services
```

**Cultural Note**: This naming convention honors ancient wisdom while building modern technology. Each deity's characteristics guide the agent's behavior and decision-making priorities.

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