# Daily Workflow

## Morning Or Session Start

1. Open the project repo in Claude Code or Codex.
2. Confirm the assistant is not running from the private/main Obsidian vault.
3. If needed, mention the work-log vault path explicitly.

Example:

```text
For this session, use /path/to/ai-work-logs as the AI work-log vault.
Do not inspect my private/main Obsidian vault.
```

## During Work

Add quick manual notes when useful:

```text
<work-log-root>/inbox/YYYY/MM/DD/notes/
```

Use short notes. Do not paste credentials or raw customer/private data.

## Session End

Ask the assistant:

```text
Use capture-work-session to capture this session into /path/to/ai-work-logs.
Redact secrets and sensitive data.
```

The output should go to:

```text
<work-log-root>/inbox/YYYY/MM/DD/conversations/
```

## End Of Day

Ask:

```text
Use daily-work-log to generate today's work daily log from /path/to/ai-work-logs.
```

The output should go to:

```text
<work-log-root>/generated/YYYY/MM/YYYY-MM-DD.md
```

## Review

Review:

- Whether tags are correct.
- Whether any sensitive content was included.
- Whether follow-ups are actionable.
- Whether generated `#work/learn` notes are actually durable knowledge.

Only after review should you copy or link the generated note into another vault.
