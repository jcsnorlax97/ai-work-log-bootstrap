# Global Claude Code Instructions

Use these instructions in `~/.claude/CLAUDE.md` if you want Claude Code to remember the AI work-log workflow.

## Daily Work Log Capture

Keep the setup repo and the work-log data separate.

Recommended setup repo:

```text
/path/to/ai-work-log-bootstrap
```

Recommended independent work-log root:

```text
macOS:   ~/Documents/a-ai-obsidian-vaults/ai-work-logs
Windows: %USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs
```

When a session is about a specific project, remember that the end-of-day log system expects source material under:

```text
<work-log-root>/inbox/YYYY/MM/DD/conversations/
<work-log-root>/inbox/YYYY/MM/DD/notes/
```

Generated daily logs go to:

```text
<work-log-root>/generated/YYYY/MM/YYYY-MM-DD.md
```

If the user says "capture this session", "save this session to the daily log inbox", "wrap up this session", or similar:

1. Prefer using `/path/to/ai-work-log-bootstrap/skills/capture-work-session/SKILL.md` if it is available.
2. Use the user's local date.
3. Create or update a markdown capture file in today's `conversations/` folder.
4. Include source assistant, project name, topic, goals, work completed, decisions, bugs or blockers, useful commands, files touched, notes, steps, and follow-ups.
5. Redact secrets, tokens, credentials, private keys, cookies, and sensitive customer/private data.
6. Use `#ai/claude` for Claude Code source material.

Do not inspect the user's private/main Obsidian vault root.

Do not scan parent folders such as `~/Documents` or `%USERPROFILE%\Documents`.

Do not follow symlinks, shortcuts, or junctions from the work-log root into private vaults or unrelated folders.

Do not rely on memory alone for end-of-day logs. Important work conversations should be saved into the daily inbox as files.
