---
name: capture-assistant-session
description: Capture the current Claude Code, Codex, or AI coding assistant session into a private AI work-log vault as a redacted markdown summary.
---

# Capture Assistant Session

## Overview

Create a safe, summarized capture of the current AI assistant session and save
it to the AI work-log vault inbox. The session may have `work`, `personal`, or
`mixed` scope; the skill name describes the source, not the life area.

## Output Location

Resolve the work-log root in this order:

1. A path explicitly provided by the user.
2. `AI_WORK_LOG_ROOT`, if available.
3. `WORK_DAILY_LOG_ROOT`, if available.
4. A nearby `ai-work-logs/` folder.
5. A nearby `work_daily_logs/` folder only as a compatibility fallback.

Recommended production roots:

```text
macOS:   ~/Documents/a-ai-obsidian-vaults/ai-work-logs/
Windows: %USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs\
```

Write the capture file to:

```text
<work-log-root>/inbox/YYYY/MM/DD/conversations/
```

Use the user's local date unless the user gives a different date.

## Security Boundary

- Prefer an independent AI work-log vault outside the tool repo and outside the user's private/main Obsidian vault.
- Do not inspect the user's private/main Obsidian vault root.
- Do not scan parent folders such as `~/Documents` or `%USERPROFILE%\Documents`.
- Do not follow symlinks, shortcuts, or junctions from the work-log vault into private vaults or unrelated folders.
- Create only the specific date folder needed for the capture.

## File Name

Use a stable, descriptive markdown filename:

```text
<assistant>-<project-or-topic>.md
```

Examples:

```text
claude-code-api-debugging.md
claude-code-customer-incident.md
codex-backend-refactor.md
```

If a matching file already exists, update it instead of creating duplicates.

## Workflow

1. Infer the assistant name: `Claude Code`, `Codex`, or the assistant named by the user.
2. Infer the project name from the current working directory, repository, user message, or session content.
3. Infer a short topic from the session goal.
4. Infer a durable `domain` such as `software_engineering`, `ai`, or the
   relevant project/area. Reuse the central AI OS capture vocabulary when
   available.
5. Infer `scope: work | personal | mixed`. Use `mixed` only when the session
   materially serves both work and personal systems.
6. Resolve the work-log root and create today's nested inbox folders if needed.
7. Write or update one markdown capture file.
8. Redact sensitive values before writing.
9. Report the capture file path and any assumptions.

## Capture Format

Use this structure:

```markdown
---
status: inbox
routing_class: assistant_session
source_type: assistant_conversation
source: claude-code-or-codex
project:
domain:
scope:
topic:
candidate_tags:
  - ai/assistant-session
  - scope-appropriate/candidate
needs_review: true
---

# Conversation Capture - YYYY-MM-DD - Short Topic

Source assistant: Claude Code / Codex
Project:
Domain:
Scope:
Topic:
Time range:

## Goals

- ...

## Work Completed

- ...

## Decisions

- ...

## Bugs, Errors, Or Blockers

- ...

## Useful Commands Or Files

- ...

## Notes

- ...

## Steps

1. ...

## Follow-ups

- ...

## Redactions

- Redacted secrets, tokens, credentials, private keys, cookies, and sensitive customer/private data.
```

Choose scope-appropriate candidate tags. Do not add `work/*` tags merely
because the capture is stored in the AI work-log vault.

## Redaction Rules

Before writing the capture, remove or replace:

- API keys, access tokens, refresh tokens, session IDs, cookies, and passwords.
- Private keys, certificates, SSH keys, and signing secrets.
- Customer private data, personal data, private URLs, and internal confidential details.
- Full stack traces or logs that contain sensitive values.

Use `[redacted]` for removed values.

Do not claim a value was safely captured if it was omitted for safety. Say it was redacted.

## What To Include

Include:

- Goals discussed.
- Completed work.
- Important decisions.
- Root causes, fixes, and blockers.
- Useful commands, file paths, and verification steps.
- Reusable knowledge as `Notes`.
- Repeatable procedures as `Steps`.
- Follow-ups.

Exclude:

- Small talk.
- Repeated status messages.
- Raw transcript dumps.
- Long code blocks unless a short excerpt is necessary.

## Relationship To Daily Work Log

This skill creates source material in `inbox/.../conversations/`.

It does not create the final daily note. At end of day, run `daily-work-log` to generate:

```text
<work-log-root>/generated/YYYY/MM/YYYY-MM-DD.md
```
