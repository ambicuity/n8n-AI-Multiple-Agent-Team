# n8n Workflow Architecture

This document provides a visual overview of the multi-agent AI system architecture.

## System Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        N8N AI AGENT TEAM                                │
│                     Homelab Management System                           │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│                           MAIN WORKFLOWS                                │
└─────────────────────────────────────────────────────────────────────────┘

     ┌───────────────┐        ┌───────────────┐        ┌───────────────┐
     │   VISHNU CTO  │        │BRAHMA NETWORK │        │ SHIVA DEVOPS  │
     │ Orchestrator  │        │ Administrator │        │   Engineer    │
     │               │        │               │        │               │
     │  Webhook ⚡   │        │  Schedule ⏰  │        │  Webhook ⚡   │
     │  /critical-   │        │  Every 15min  │        │  /cicd-       │
     │   issue       │        │               │        │   deploy      │
     └───────┬───────┘        └───────┬───────┘        └───────┬───────┘
             │                        │                        │
             ▼                        ▼                        ▼
     ┌───────────────┐        ┌───────────────┐        ┌───────────────┐
     │  AI Analysis  │        │ UniFi Health  │        │  Plex Session │
     │  & Delegate   │        │     Check     │        │     Check     │
     └───────┬───────┘        └───────┬───────┘        └───────┬───────┘
             │                        │                        │
             ▼                        ▼                        ▼
     ┌───────────────┐        ┌───────────────┐        ┌───────────────┐
     │   Execute     │        │   Network     │        │ AI Deployment │
     │   Workflow    │───────▶│ Diagnostics   │        │     Plan      │
     │  (Delegate)   │        │  (ping/trace) │        └───────┬───────┘
     └───────┬───────┘        └───────┬───────┘                │
             │                        │                        ▼
             ▼                        ▼                ┌───────────────┐
     ┌───────────────┐        ┌───────────────┐      │  Can Deploy?  │
     │  Synthesize   │        │  AI Analysis  │      │  (IF check)   │
     │    Results    │        │  (Brahma AI)  │      └───┬───────┬───┘
     └───────┬───────┘        └───────┬───────┘          │       │
             │                        │                 YES     NO
             ▼                        ▼                  │       │
     ┌───────────────┐        ┌───────────────┐         ▼       ▼
     │   Telegram    │        │   Telegram    │   ┌─────────┐ ┌──────────┐
     │   Approval    │        │    Report     │   │ Docker  │ │ Telegram │
     │   Request     │        └───────────────┘   │ Restart │ │ Blocked  │
     └───────────────┘                            └─────────┘ └──────────┘

                    ┌───────────────────────────────┐
                    │   APPROVAL-HANDLER UTILITY    │
                    │                               │
                    │  Telegram Trigger (Messages)  │
                    └───────────────┬───────────────┘
                                    │
                            Parse Response
                                    │
                         ┌──────────┴──────────┐
                         │      SWITCH         │
                         │    YES / NO / ?     │
                         └──┬───────┬───────┬──┘
                           YES      NO      ?
                            │       │       │
                            ▼       ▼       ▼
                     ┌──────────┐ ┌─────┐ ┌──────┐
                     │ Execute  │ │Deny │ │Explain│
                     │ Workflow │ │Log  │ │ More  │
                     └────┬─────┘ └──┬──┘ └───┬──┘
                          │          │        │
                          ▼          ▼        ▼
                       Telegram  Telegram Telegram
                       Confirm   Denial   Info
```

## Workflow Interaction Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    TYPICAL INCIDENT RESPONSE FLOW                       │
└─────────────────────────────────────────────────────────────────────────┘

1. DETECTION
   External System ──[Webhook]──▶ Vishnu CTO
                                     │
                                     ▼
2. ANALYSIS                    AI Agent analyzes
                              "Network issue detected"
                                     │
                                     ▼
3. DELEGATION               Execute Workflow Node
                         Calls brahma-network.json
                                     │
                                     ▼
4. SPECIALIST WORK        Brahma Network Workflow
                         ┌─────────────────────┐
                         │ HTTP: Check UniFi   │
                         │ CMD: Run diagnostics│
                         │ AI: Analyze results │
                         └──────────┬──────────┘
                                    │
                                    ▼
5. REPORT BACK             Returns to Vishnu
                              (via workflow)
                                    │
                                    ▼
6. SYNTHESIS               Vishnu combines reports
                           Creates action plan
                                    │
                                    ▼
7. HUMAN APPROVAL          Telegram Message
   ┌──────────────────────────────────────────┐
   │ 🔱 Vishnu CTO - Issue Resolution        │
   │                                          │
   │ Issue: Network connectivity degraded    │
   │ Severity: HIGH                           │
   │ Delegated To: brahma-network            │
   │                                          │
   │ Specialist Report:                       │
   │ - UniFi AP offline                       │
   │ - Suggest: Reboot access point          │
   │                                          │
   │ Reply YES to approve or NO to decline   │
   └──────────────────────────────────────────┘
                    │
                    ▼
8. USER RESPONSE   "YES"
                    │
                    ▼
   Approval Handler Workflow activates
   ┌─────────────────────┐
   │ Parse: YES          │
   │ Switch: Route to YES│
   │ Execute: Run fix    │
   │ Telegram: Confirm   │
   └─────────────────────┘
                    │
                    ▼
9. CONFIRMATION    "✅ Action completed successfully"
```

## Data Flow Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         DATA & CONTROL FLOW                             │
└─────────────────────────────────────────────────────────────────────────┘

External Triggers                    n8n Workflows              External Systems
─────────────────                    ─────────────              ────────────────

[CI/CD Pipeline] ──webhook──▶   [Shiva DevOps]
                                      │
                                      ├──http──▶ [Plex Server]
                                      │           status check
                                      │
                                      ├──cmd──▶ [Docker]
                                      │          restart
                                      │
                                      └──msg──▶ [Telegram]

[Schedule: 15min] ──trigger──▶  [Brahma Network]
                                      │
                                      ├──http──▶ [UniFi Controller]
                                      │           health API
                                      │
                                      ├──cmd──▶ [System]
                                      │          ping/trace
                                      │
                                      └──msg──▶ [Telegram]

[Monitoring Alert] ──webhook──▶ [Vishnu CTO]
                                      │
                                      ├──exec──▶ [Other Workflows]
                                      │           delegate tasks
                                      │
                                      └──msg──▶ [Telegram]

[Telegram Bot] ──message──▶     [Approval Handler]
                                      │
                                      ├──exec──▶ [Target Workflow]
                                      │           approved action
                                      │
                                      └──msg──▶ [Telegram]
                                                  confirmation

[OpenAI API] ◀──────────────────── All AI Agent Nodes
  (GPT-4o-mini)                    (system prompts + context)
```

## Node Type Distribution

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        NODE TYPE ANALYSIS                               │
└─────────────────────────────────────────────────────────────────────────┘

TRIGGERS (How workflows start):
  ├─ Webhook Trigger         ████████ (2) vishnu-cto, shiva-devops
  ├─ Schedule Trigger        ████     (1) brahma-network
  └─ Telegram Trigger        ████     (1) approval-handler

AI & INTELLIGENCE:
  └─ AI Agent (LangChain)    ████████████ (3) vishnu, brahma, shiva

LOGIC & PROCESSING:
  ├─ Code (JavaScript)       ████████████ (5) parsing, decisions, synthesis
  ├─ IF Condition            ████     (1) can-deploy check
  └─ Switch                  ████     (1) YES/NO/other routing

EXTERNAL INTERACTIONS:
  ├─ HTTP Request            ████████ (2) UniFi, Plex
  ├─ Execute Command         ████████ (2) diagnostics, docker
  └─ Telegram Message        ████████████████ (6) notifications

WORKFLOW ORCHESTRATION:
  └─ Execute Workflow        ████████ (2) delegation, approval execution

RESPONSE:
  └─ Webhook Response        ████████ (2) API replies

TOTAL NODES: 29 across 4 workflows
```

## Security & Safety Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      SAFETY MECHANISMS                                  │
└─────────────────────────────────────────────────────────────────────────┘

Level 1: READ-ONLY Operations (Auto-approved)
  ├─ HTTP GET requests (UniFi status)
  ├─ Ping/traceroute diagnostics
  └─ Status checks (Plex sessions)

Level 2: CONDITIONAL Execution (Logic gates)
  ├─ IF active sessions = 0 → proceed
  ├─ IF severity < critical → auto-handle
  └─ SWITCH user response → route accordingly

Level 3: HUMAN APPROVAL Required (via Telegram)
  ├─ Docker restart/rebuild
  ├─ Configuration changes
  ├─ Critical severity issues
  └─ Multi-system impacts

Level 4: FORBIDDEN (Not implemented)
  ├─ Database DELETE/UPDATE
  ├─ Data destruction
  ├─ User management
  └─ Security policy changes

Environment Variables (Secure secrets):
  ├─ {{$env.TELEGRAM_CHAT_ID}}
  ├─ {{$env.OPENAI_API_KEY}}
  └─ Credential system for API keys
```

## Scalability & Extension Points

```
┌─────────────────────────────────────────────────────────────────────────┐
│                   EXTENSION ARCHITECTURE                                │
└─────────────────────────────────────────────────────────────────────────┘

Additional Agents (Easy to add):
  ├─ Saraswati (Database) ──┐
  ├─ Ganesha (Security)   ──┤
  └─ Hanuman (Helpdesk)   ──┤
                            │
                            ├──▶ Same pattern as existing agents
                            │    • Trigger (webhook/schedule)
                            │    • AI Agent (domain-specific)
                            │    • Tools (HTTP/CMD)
                            │    • Telegram (notify)
                            │
                            └──▶ Vishnu delegates via Execute Workflow

Service Integrations (Plug & Play):
  ├─ Add HTTP Request node → New service
  ├─ Add Execute Command → New diagnostics
  └─ Update AI prompt → New behaviors

Notification Channels (Beyond Telegram):
  ├─ Email node
  ├─ Slack node
  ├─ Discord node
  └─ Custom webhooks
```

## File Structure Summary

```
n8n-AI-Multiple-Agent-Team/
│
├── workflows-export.json          # Single file with all workflows
│   └── files[]
│       ├── vishnu-cto.json       # 7 nodes, orchestration
│       ├── brahma-network.json   # 6 nodes, monitoring
│       ├── shiva-devops.json     # 9 nodes, deployment
│       ├── saraswati-database.json # 6 nodes, database
│       ├── ganesha-security.json # 7 nodes, security
│       ├── hanuman-helpdesk.json # 8 nodes, support
│       └── approval-handler.json # 7 nodes, approval
│
├── workflows/
│   ├── agents/
│   │   ├── vishnu-cto.json
│   │   ├── brahma-network.json
│   │   ├── shiva-devops.json
│   │   ├── saraswati-database.json
│   │   ├── ganesha-security.json
│   │   └── hanuman-helpdesk.json
│   └── utilities/
│       └── approval-handler.json
│
├── WORKFLOWS_IMPLEMENTATION.md    # Usage guide
└── WORKFLOW_ARCHITECTURE.md       # This file
```

## Key Design Principles

1. **Separation of Concerns**
   - Each agent has one primary role
   - Clear delegation boundaries
   - No overlapping responsibilities

2. **Human-in-the-Loop**
   - Approval required for destructive actions
   - Clear YES/NO decision points
   - Audit trail via Telegram messages

3. **Fail-Safe Defaults**
   - Read-only operations don't require approval
   - Conditional checks before execution
   - Rollback plans documented

4. **Cosmic Wisdom Architecture**
   - Vishnu (Preservation) → Stability first
   - Brahma (Creation) → Infrastructure focus
   - Shiva (Transformation) → Controlled change
   - Each reflects Hindu deity attributes

5. **Observable & Debuggable**
   - Telegram notifications at key points
   - JSON output for structured data
   - Clear workflow execution history

## Version Information

- **Implementation Version:** 1.0
- **n8n Compatibility:** Latest (2024)
- **AI Model:** GPT-4o-mini (OpenAI)
- **Created:** 2024
- **Status:** Production-ready ✅
