---
name: automation-vault-sync
description: Sync markdown-ready Vault Sync Blocks from Codex heartbeat automations into the AI work-log vault inbox. Use when the user asks to save, sync, archive, or capture an automation digest/output into the AI work-log Obsidian vault.
---

# Automation Vault Sync

## Overview

Save a markdown-ready automation output into the isolated AI work-log vault without mixing it with human assistant conversations.

This skill is for automation digests such as Codex heartbeat outputs. It does not run the automation, search the web, or regenerate the digest. It only syncs a provided or visible `Vault Sync Block` into the vault.

## Folder Contract

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

Automation outputs go here:

```text
<work-log-root>/inbox/YYYY/MM/DD/automations/<automation-id>/
```

Do not write automation digests to `conversations/`. That folder is reserved for human assistant session captures.

## Vault Sync Block Contract

Prefer a fenced block labeled `markdown` that contains frontmatter and note content:

````markdown
```markdown
---
status: inbox
source: codex-heartbeat
project: example-project
scope: work
automation_id: ai-reel
topic: Daily IG Reel pain point digest
candidate_tags:
  - work/log
  - automation/codex
needs_review: true
---

# Daily IG Reel Pain Point Digest - 2026-05-19

...
```
````

If the block is missing `automation_id`, infer it from the user request, the automation name, or the thread context. If it remains ambiguous, ask one concise question before writing.

## Workflow

1. Identify the target `Vault Sync Block`.
   - Use the latest visible block when the user asks to sync the latest digest.
   - Use the explicitly pasted block when provided.
2. Resolve the target date.
   - Prefer a date in the note title or frontmatter.
   - Otherwise use the user's local date.
3. Resolve `automation_id`.
   - Prefer `automation_id` from frontmatter.
   - Otherwise use a stable lowercase slug from the automation name.
4. Resolve `scope`.
   - Prefer `scope` from frontmatter.
   - Use one of `work`, `personal`, or `mixed`.
   - Infer from the automation purpose when missing; use `mixed` only when the
     digest materially serves both work and personal systems.
5. Redact secrets before writing.
   - Remove API keys, tokens, passwords, cookies, private keys, customer private data, and confidential URLs.
   - Use `[redacted]` where content is removed.
6. Create only the exact target folder for that date and automation id.
7. Write or update one markdown file:

```text
<work-log-root>/inbox/YYYY/MM/DD/automations/<automation-id>/YYYY-MM-DD-digest.md
```

Use a more specific suffix only when the automation produces multiple distinct daily notes, for example `YYYY-MM-DD-market-watch.md`.

## Existing File Handling

If the target file already exists:

- Read it first.
- If it contains the managed markers below, replace only the managed section.
- If it has no managed markers, append a new `## Synced Update - YYYY-MM-DD HH:mm` section instead of overwriting.
- Do not create duplicate files for the same automation/date/topic.

Managed markers:

```markdown
<!-- automation-vault-sync:start -->
...
<!-- automation-vault-sync:end -->
```

When writing a new file, wrap the synced block body in those markers so later updates are safe.

## Security Rules

- Do not inspect the user's private/main Obsidian vault root.
- Do not scan parent folders such as `~/Documents` or `%USERPROFILE%\Documents`.
- Do not follow symlinks, shortcuts, or junctions from the work-log vault into private folders.
- Do not delete files or directories.
- Do not batch-modify inbox history.
- Treat generated tags as `candidate_tags` until reviewed.

## Output

Report:

- The file path written.
- The automation id used.
- The date used.
- The scope used.
- Whether the file was created, updated, or appended.
- Any redactions or assumptions.
