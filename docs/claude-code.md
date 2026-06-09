# Claude Code Setup

## Principle

Run Claude Code inside project repositories. Do not run it inside your private/main Obsidian vault or a parent folder that contains that vault.

## Session Capture

Use the repo-local skill file and explicitly provide the work-log vault:

```text
Read /path/to/ai-work-log-bootstrap/skills/capture-assistant-session/SKILL.md and use it to capture this session into /path/to/ai-work-logs.
```

End-of-day generation:

```text
Read /path/to/ai-work-log-bootstrap/skills/daily-work-log/SKILL.md and use it to generate today's work daily log from /path/to/ai-work-logs.
```

If a saved assistant response contains a markdown-ready `Vault Sync Block`, sync it as an automation digest:

```text
Read /path/to/ai-work-log-bootstrap/skills/automation-vault-sync/SKILL.md and use it to sync the provided Vault Sync Block into /path/to/ai-work-logs.
```

## Optional Global Claude Memory

Claude Code can load global instructions from:

```text
macOS/Linux: ~/.claude/CLAUDE.md
Windows:     %USERPROFILE%\.claude\CLAUDE.md
```

Copy or merge the content of:

```text
templates/global-CLAUDE.md
```

Then replace placeholder paths with your actual tool repo and work-log vault paths.

Do not let this file point Claude Code at your private/main Obsidian vault.

## Optional SessionEnd Hook

The hook writes metadata only by default. It does not copy raw transcripts unless explicitly opted in.

After running the bootstrap script, the work-log vault contains platform-specific hook templates:

```text
templates/claude-settings-hooks.macos.example.json
templates/claude-settings-hooks.windows.example.json
```

macOS command pattern:

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "AI_WORK_LOG_ROOT=\"$HOME/Documents/a-ai-obsidian-vaults/ai-work-logs\" python3 \"$HOME/Documents/a-ai-obsidian-vaults/ai-work-logs/hooks/capture_session_end.py\"",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

Windows command pattern:

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "set \"AI_WORK_LOG_ROOT=%USERPROFILE%\\Documents\\a-ai-obsidian-vaults\\ai-work-logs\" && python \"%USERPROFILE%\\Documents\\a-ai-obsidian-vaults\\ai-work-logs\\hooks\\capture_session_end.py\"",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

Run this inside Claude Code after editing settings:

```text
/hooks
```

## Raw Transcript Opt-In

Only for low-risk sessions:

```text
WORK_DAILY_LOG_COPY_RAW_TRANSCRIPT=1
```

Do not enable raw transcript copying globally.
