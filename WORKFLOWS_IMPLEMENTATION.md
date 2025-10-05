# n8n Workflow Implementation Guide

## Overview

This repository contains complete, executable n8n workflow JSON files for a multi-agent AI homelab management system. All workflows are based on the architectural specifications from Chapter 8 of the project documentation.

## Files Included

### Main Export File
- **`workflows-export.json`** - Single JSON file containing all 7 workflows in the required format with a `files` array

### Individual Workflow Files

**AI Agent Workflows:**
- **`workflows/agents/vishnu-cto.json`** - CTO Orchestrator Agent (Preservation)
- **`workflows/agents/brahma-network.json`** - Network Administrator Agent (Creation)
- **`workflows/agents/shiva-devops.json`** - DevOps Engineer Agent (Transformation)
- **`workflows/agents/saraswati-database.json`** - Database Administrator Agent (Knowledge)
- **`workflows/agents/ganesha-security.json`** - Security Engineer Agent (Problem-Solving)
- **`workflows/agents/hanuman-helpdesk.json`** - Helpdesk Support Agent (Service)

**Utility Workflows:**
- **`workflows/utilities/approval-handler.json`** - Human-in-the-Loop Approval Handler

## Workflow Details

### 1. Vishnu CTO Agent (vishnu-cto.json)

**Role:** Orchestrator and CTO Agent  
**Trigger:** Webhook (POST to `/critical-issue`)  
**Version:** 1.0

**Nodes:**
- Webhook - Critical Issue (receives alerts)
- AI Agent - Vishnu CTO (analyzes and delegates)
- Code - Delegation Logic (parses AI response)
- Execute Workflow - Delegate (calls specialist agents)
- Code - Synthesize Results (combines reports)
- Telegram - Approval Request (sends to human)
- Webhook Response (returns status)

**Key Features:**
- Receives critical issues via webhook
- AI-powered analysis and delegation to specialist agents
- Synthesizes multi-agent reports
- Requests human approval via Telegram
- Uses system prompt from Chapter 8

### 2. Brahma Network Agent (brahma-network.json)

**Role:** Network Administrator  
**Trigger:** Schedule (Every 15 minutes)  
**Version:** 1.0

**Nodes:**
- Schedule Trigger - Every 15 min
- HTTP Request - UniFi Status (checks `http://unifi.local:8443`)
- Execute Command - Net Diagnostics (ping & traceroute)
- Code - Combine Network Data
- AI Agent - Brahma Network (analyzes results)
- Telegram - Network Report (sends notifications)

**Key Features:**
- Scheduled monitoring every 15 minutes
- Checks UniFi Controller health via HTTP
- Runs network diagnostics (ping, traceroute)
- AI agent analyzes network data
- Reports status via Telegram

### 3. Shiva DevOps Agent (shiva-devops.json)

**Role:** DevOps Engineer  
**Trigger:** Webhook (POST to `/cicd-deploy`)  
**Version:** 1.0

**Nodes:**
- Webhook Trigger - CI/CD Push
- HTTP Request - Plex Session Check (`http://plex.local:32400`)
- AI Agent - Shiva DevOps (creates deployment plan)
- Code - Deployment Decision
- IF - Can Deploy? (checks active sessions)
- Execute Command - Docker Restart
- Telegram - Deployment Blocked/Success
- Webhook Response

**Key Features:**
- Triggered by CI/CD webhook
- Checks for active Plex sessions before deploying
- AI-powered deployment planning
- Conditional execution based on system state
- Notifications for success/blocked deployments

### 4. Saraswati Database Agent (saraswati-database.json)

**Role:** Database Administrator and Knowledge Keeper  
**Trigger:** Schedule (Every 30 minutes)  
**Version:** 1.0

**Nodes:**
- Schedule Trigger - Every 30 min
- HTTP Request - Database Status (checks `http://postgres.local:5432`)
- Execute Command - Query Analysis (PostgreSQL diagnostics)
- Code - Combine Database Data
- AI Agent - Saraswati Database (analyzes results)
- Telegram - Database Report (sends notifications)

**Key Features:**
- Scheduled database monitoring every 30 minutes
- Database health checks via HTTP
- Query performance analysis
- Slow query detection
- AI-powered optimization recommendations
- Reports via Telegram

### 5. Ganesha Security Agent (ganesha-security.json)

**Role:** Security Engineer and Obstacle Remover  
**Trigger:** Schedule (Every 10 minutes)  
**Version:** 1.0

**Nodes:**
- Schedule Trigger - Every 10 min
- Execute Command - Auth Logs (checks failed login attempts)
- Execute Command - Fail2ban Status
- Execute Command - Certificate Check (SSL/TLS expiration)
- Code - Combine Security Data
- AI Agent - Ganesha Security (threat analysis)
- Telegram - Security Report (sends alerts)

**Key Features:**
- Frequent security monitoring every 10 minutes
- Authentication log analysis
- Fail2ban status monitoring
- Certificate expiration tracking
- AI-powered threat assessment
- Immediate alerts for security incidents

### 6. Hanuman Helpdesk Agent (hanuman-helpdesk.json)

**Role:** Helpdesk Agent and Devoted Servant  
**Trigger:** Telegram (on message)  
**Version:** 1.0

**Nodes:**
- Telegram Trigger - User Requests
- Code - Parse User Request (categorization)
- AI Agent - Hanuman Helpdesk (triage and response)
- Code - Process Response
- IF - Should Escalate?
- Telegram - Direct Response
- Telegram - Escalation Notice
- Execute Workflow - Escalate to Vishnu

**Key Features:**
- Real-time user support via Telegram
- Intelligent request categorization
- AI-powered triage and troubleshooting
- Automatic escalation to specialist agents
- Friendly, empathetic communication
- User satisfaction tracking

### 7. Approval Handler (approval-handler.json)

**Role:** Utility Workflow for Human-in-the-Loop  
**Trigger:** Telegram (on message)  
**Version:** 1.0

**Nodes:**
- Telegram Trigger - On Message
- Code - Parse User Response (YES/NO/other)
- Switch - YES/NO/Other (routes flow)
- Execute Workflow - Run Approved Fix
- Telegram - Confirm Execution/Denial/Other Response

**Key Features:**
- Listens for Telegram messages
- Parses user approval responses (YES/NO)
- Routes based on response
- Executes approved workflows
- Confirms actions back to user

## Configuration Requirements

### Environment Variables
All workflows use placeholders that need to be configured in your n8n environment:

```bash
TELEGRAM_CHAT_ID=your_chat_id
OPENAI_API_KEY=your_openai_api_key
```

### Credentials
The following n8n credentials need to be created:

1. **Telegram API** (id: 1, name: "Telegram API")
   - Required for all Telegram nodes
   - Add your bot token from BotFather

2. **OpenAI Account** (for AI Agent nodes)
   - Add your OpenAI API key
   - Model: gpt-4o-mini (cost-effective) or gpt-4

### Service URLs
Update these placeholder URLs to match your environment:

- `http://unifi.local:8443` - UniFi Controller
- `http://plex.local:32400` - Plex Media Server
- `http://proxmox.local` - Proxmox VE (if used)

## Installation Instructions

### Method 1: Import Individual Workflows

1. Open n8n web interface
2. Click **Workflows** → **Add Workflow**
3. Click the three dots menu (⋯) → **Import from File**
4. Select one of the individual workflow JSON files
5. Configure credentials and environment variables
6. Activate the workflow

Repeat for all 7 workflows.

### Method 2: Programmatic Import

Use the main export file with the n8n API or bulk import tool:

```bash
# Example using the workflows-export.json structure
# This file contains all 7 workflows in a single JSON with 'files' array
cat workflows-export.json | jq -r '.files[] | @json' | while read workflow; do
  echo "$workflow" | n8n import:workflow --input=-
done
```

## Workflow Execution Flow

### Typical Scenario: Critical Issue Response

1. **Alert Triggered** → Vishnu CTO receives webhook with issue details
2. **Analysis** → Vishnu AI Agent analyzes and determines delegation
3. **Delegation** → Vishnu calls Brahma Network workflow via Execute Workflow
4. **Specialist Work** → Brahma checks network, runs diagnostics
5. **Synthesis** → Vishnu receives Brahma's report and synthesizes
6. **Human Approval** → Vishnu sends approval request via Telegram
7. **User Response** → Approval Handler workflow processes YES/NO
8. **Execution** → If approved, fixes are executed
9. **Confirmation** → User receives completion notification

### Scheduled Monitoring

1. **Schedule Trigger** → Brahma Network runs every 15 minutes
2. **Data Collection** → HTTP Request to UniFi, Execute Command for diagnostics
3. **Analysis** → AI Agent processes network data
4. **Notification** → Report sent via Telegram (only if issues detected)

### CI/CD Deployment

1. **Webhook** → Shiva DevOps receives deployment request
2. **Pre-checks** → Checks active Plex sessions
3. **AI Planning** → Creates deployment plan with risk assessment
4. **Conditional Logic** → IF active sessions = 0, proceed; else wait
5. **Execution** → Docker restart command
6. **Notification** → Success or blocked status via Telegram

## Customization Guide

### Modifying AI Agent Behavior

Edit the `systemMessage` parameter in AI Agent nodes to change:
- Decision-making criteria
- Output format requirements
- Escalation triggers
- Personality and communication style

### Adjusting Schedule

Change the Schedule Trigger interval in brahma-network.json:

```json
"parameters": {
  "rule": {
    "interval": [
      {
        "field": "minutes",
        "minutesInterval": 15  // Change this value
      }
    ]
  }
}
```

### Adding New Services

To monitor additional services, duplicate and modify brahma-network.json:
1. Change the HTTP Request URL
2. Update the Execute Command for service-specific checks
3. Adjust the AI Agent system prompt for the new domain

## Testing

### Test Vishnu CTO Workflow

```bash
curl -X POST http://your-n8n-instance/webhook/critical-issue \
  -H "Content-Type: application/json" \
  -d '{
    "service": "plex",
    "issue": "Service is down",
    "severity": "high"
  }'
```

### Test Shiva DevOps Workflow

```bash
curl -X POST http://your-n8n-instance/webhook/cicd-deploy \
  -H "Content-Type: application/json" \
  -d '{
    "service": "plex",
    "version": "1.32.8",
    "action": "update"
  }'
```

### Test Approval Handler

Send a message to your Telegram bot:
```
YES APR-12345
```

## Validation

All workflows have been validated for:
- ✅ Valid JSON syntax
- ✅ Version set to "1.0"
- ✅ Complete node configurations
- ✅ Proper connection definitions
- ✅ Required node types present
- ✅ Environment variable placeholders
- ✅ Example URLs for services
- ✅ AI Agent system prompts from Chapter 8

## Troubleshooting

### Workflow Not Executing

1. Check workflow is **activated** (toggle in top-right)
2. Verify credentials are properly configured
3. Check webhook URLs are correct
4. Review execution history for errors

### AI Agent Not Responding

1. Verify OpenAI API key is valid
2. Check model selection (gpt-4o-mini or gpt-4)
3. Review system prompt formatting
4. Check for API rate limits or quota issues

### Telegram Notifications Not Sending

1. Verify Telegram bot token in credentials
2. Check TELEGRAM_CHAT_ID environment variable
3. Ensure workflow is activated
4. Test with manual execution first

### Execute Workflow Node Failing

1. Verify target workflow exists and is activated
2. Check workflow ID/name matches
3. Ensure no circular dependencies
4. Review permissions if using separate n8n instances

## Architecture Notes

This implementation follows the cosmic wisdom architecture from Chapter 8:

- **Vishnu (Preservation)** - Maintains stability, coordinates team
- **Brahma (Creation)** - Builds and manages infrastructure
- **Shiva (Transformation)** - Deploys changes and updates
- **Approval Handler** - Human-in-the-Loop pattern for safety

Each agent has specialized knowledge and clear delegation boundaries, creating a robust multi-agent system for homelab management.

## Support

For issues or questions:
1. Review the main README.md in this repository
2. Check Chapter 8 (AI Team) in docs/08-AI-Team.md
3. Open an issue on GitHub
4. Consult n8n documentation at https://docs.n8n.io

## Version History

- **v1.0** - Initial implementation with all 6 AI agent workflows + 1 utility
  - Vishnu CTO Agent (Orchestrator - Preservation)
  - Brahma Network Agent (Infrastructure - Creation)
  - Shiva DevOps Agent (Deployment - Transformation)
  - Saraswati Database Agent (Data - Knowledge)
  - Ganesha Security Agent (Protection - Problem-Solving)
  - Hanuman Helpdesk Agent (Support - Service)
  - Approval Handler (Human-in-the-Loop)
