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

