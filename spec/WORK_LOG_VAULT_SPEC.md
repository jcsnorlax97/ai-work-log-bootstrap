# Work-Log Vault Spec

This spec defines the portable AI work-log vault used by Claude Code, Codex, and other coding assistants.

## Purpose

The work-log vault is a private, Obsidian-compatible staging area for summarized and reviewed AI work-session notes.

It is separate from:

- The shared setup repo.
- The user's private/main Obsidian vault.
- Assistant application history.
- Raw transcript storage.

## Root Resolution

Assistants and scripts should resolve the work-log root in this order:

1. A path explicitly provided by the user.
2. `AI_WORK_LOG_ROOT`.
3. `WORK_DAILY_LOG_ROOT`.
4. A nearby `ai-work-logs/` folder.
5. A nearby `work_daily_logs/` folder only as a compatibility fallback.

Recommended production roots:

```text
macOS:   ~/Documents/a-ai-obsidian-vaults/ai-work-logs/
Windows: %USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs\
```

## Folder Layout

```text
<work-log-root>/
  README.md
  .gitignore
  inbox/
    README.md
    YYYY/
      MM/
        DD/
          conversations/
          notes/
          automations/
            <automation-id>/
  generated/
    README.md
    YYYY/
      MM/
        YYYY-MM-DD.md
  templates/
  hooks/
```

## Inbox Contract

Conversation captures go here:

```text
<work-log-root>/inbox/YYYY/MM/DD/conversations/
```

Manual notes and input notes go here:

```text
<work-log-root>/inbox/YYYY/MM/DD/notes/
```

Automation digests go here:

```text
<work-log-root>/inbox/YYYY/MM/DD/automations/<automation-id>/
```

Use `conversations/` only for human assistant session captures. Use `automations/` for scheduled outputs such as Codex heartbeat digests. The execution mechanism, such as heartbeat or cron, should not be encoded as another folder layer.

Use `notes/` for:

- Human-written manual notes.
- Redacted input notes created from external sources such as shared AI
  conversations, meeting transcripts, chat excerpts, articles, papers, workflow
  ideas, and copied excerpts.

Do not put raw external transcripts into `notes/` by default.

Preferred source files:

- Redacted `.md` captures created by `capture-work-session`.
- Redacted `.md` automation digests created by `automation-vault-sync`.
- Human-written `.md` notes.
- Short `.txt` notes.

Avoid:

- Raw `.jsonl` transcripts.
- Full application logs.
- Secrets, credentials, tokens, cookies, customer private data, or confidential context.

## Generated Contract

Generated daily notes go here:

```text
<work-log-root>/generated/YYYY/MM/YYYY-MM-DD.md
```

Generated notes should be reviewable in Obsidian and should include:

```yaml
---
status: generated
needs_review: true
---
```

Generated daily notes should include a `Source Coverage` section listing which
conversation captures, input notes, manual notes, and automation digests were
included for the day.

## Capture Frontmatter

Session captures should include:

```yaml
---
status: inbox
source: codex
project: example-project
scope: work
topic: short-topic
candidate_tags:
  - work/log
  - work/learn
  - ai/codex
needs_review: true
---
```

Use `candidate_tags` because assistant classification is not authoritative.

Use `scope` as the primary work/personal boundary. Valid values:

- `work`
- `personal`
- `mixed`

Use `mixed` only when source material materially serves both work and personal
systems.

## Note Frontmatter

Manual notes and input notes should include:

```yaml
---
status: inbox
source: manual-or-external-input
project: example-project
scope: personal
topic: short-topic
candidate_tags:
  - personal/log
needs_review: true
---
```

## Automation Digest Frontmatter

Automation digests should include:

```yaml
---
status: inbox
source: codex-heartbeat
project: example-project
scope: work
automation_id: example-automation
topic: short-topic
candidate_tags:
  - work/log
  - automation/codex
needs_review: true
---
```

Use `automation_id` as the stable folder name under `automations/`.

## Tag Defaults

Default work tags:

```text
#work/log
#work/learn
#personal/log
#personal/learn
#mixed/log
#mixed/learn
#ai/claude
#ai/codex
```

Rules:

- Use `#work/*` for work-scoped source material.
- Use `#personal/*` for personal-scoped source material.
- Use `#mixed/*` when source material materially serves both work and personal
  systems.
- Use `#ai/claude` for Claude Code source material.
- Use `#ai/codex` for Codex source material.
- Use both only when both materially contributed to the same work item.
- Treat topic and learning tags as review candidates.

## Security Constraints

- Do not inspect the private/main Obsidian vault root.
- Do not scan parent folders such as `~/Documents` or `%USERPROFILE%\Documents`.
- Do not follow symlinks, shortcuts, or junctions from the work-log vault into private folders.
- Do not store raw transcript captures unless explicitly opted in for low-risk sessions.
- Do not commit the work-log vault into this bootstrap repo.
