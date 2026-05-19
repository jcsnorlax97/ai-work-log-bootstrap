# Claude Code Session Start Prompt

Use this at the start of a Claude Code session when working on a specific project.

Preferred current workflow: use `/path/to/ai-work-log-bootstrap/skills/capture-work-session/SKILL.md` near the end of the session and write to an independent AI work-log vault.

```text
For this Claude Code session, please keep an end-of-session capture for my work daily log.

Use this portable log inbox structure:

<work-log-root>/inbox/YYYY/MM/DD/conversations/

Recommended work-log root:

macOS:   ~/Documents/a-ai-obsidian-vaults/ai-work-logs
Windows: %USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs

Use today's local date for YYYY/MM/DD.

At the end of the session, create or update one markdown file in that folder named:

claude-code-<project-or-topic>.md

The capture file should include:

1. Source assistant: Claude Code
2. Project name
3. Topic
4. Main goals discussed
5. Work completed
6. Important decisions
7. Bugs, errors, or blockers
8. Useful commands or files touched
9. Notes: reusable knowledge, concepts, root causes, constraints
10. Steps: repeatable how-to procedures
11. Follow-ups

Do not include secrets, tokens, credentials, private keys, cookies, or sensitive customer/private data.
Replace sensitive values with [redacted].

Do not inspect my private/main Obsidian vault root. Do not scan parent folders or follow symlinks/shortcuts out of the work-log root.

When I say "capture this session", prefer using `/path/to/ai-work-log-bootstrap/skills/capture-work-session/SKILL.md` if it is available. Otherwise, write or update the capture file using the rules above.
```

## Short End Prompt

Use this before closing the Claude Code session:

```text
Read /path/to/ai-work-log-bootstrap/skills/capture-work-session/SKILL.md and use it to capture this session into <work-log-root>.
```
