# AI Work Log Bootstrap

Portable setup kit for capturing AI coding-assistant work sessions into an isolated, Obsidian-compatible work-log vault.

This repo contains setup docs, specs, templates, skills, hooks, and bootstrap scripts. It intentionally does **not** contain real work logs, generated notes, inbox captures, transcripts, or private Obsidian vault content.

## Core Pattern

Keep three locations separate:

```text
Tool/bootstrap repo:  ai-work-log-bootstrap
AI work-log vault:    ai-work-logs
Private Obsidian:     your main/private vault
```

Recommended macOS layout:

```text
~/Documents/a-ai-codex/ai-work-log-bootstrap/
~/Documents/a-ai-obsidian-vaults/ai-work-logs/
```

Recommended Windows layout:

```text
C:\work\ai-work-log-bootstrap\
%USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs\
```

The AI work-log vault can be opened in Obsidian as a separate lightweight vault. Claude Code and Codex may write there, but they should not browse your private/main Obsidian vault.

## What This Repo Includes

```text
bootstrap/        scripts that initialize an empty AI work-log vault
docs/             setup guides for macOS, Windows, Claude Code, and Codex
hooks/            optional Claude Code SessionEnd metadata hook
skills/           capture, automation sync, and daily-log skill definitions
spec/             folder contract, formats, and security model
templates/        vault README, capture templates, Claude prompt templates
```

## What This Repo Must Not Include

```text
inbox/
generated/
ai-work-logs/
*.jsonl
real work captures
generated daily logs
private Obsidian notes
customer data
credentials or secrets
```

## Bootstrap A New Work-Log Vault

macOS:

```bash
zsh bootstrap/macos/bootstrap-ai-work-log-vault.sh "$HOME/Documents/a-ai-obsidian-vaults/ai-work-logs"
```

Windows:

```powershell
PowerShell -ExecutionPolicy Bypass -File .\bootstrap\windows\bootstrap-ai-work-log-vault.ps1 -VaultRoot "$env:USERPROFILE\Documents\a-ai-obsidian-vaults\ai-work-logs"
```

The scripts create the work-log vault layout and copy templates/hooks. They do not modify your private/main Obsidian vault.

## Daily Workflow

1. Work in the project repo, not in your private/main Obsidian vault.
2. Use `capture-work-session` to save a summarized, redacted session capture into the AI work-log vault.
3. Use `automation-vault-sync` to save reviewed heartbeat automation digests when needed.
4. Add manual notes to the same day's inbox when needed.
5. Run `daily-work-log` at end of day to create a generated daily summary.
6. Review tags and content in the AI work-log vault.
7. Copy or link only reviewed notes into your private/main Obsidian vault if desired.

## Security Defaults

- Raw transcript copying is disabled by default.
- Generated tags are candidate tags until reviewed.
- The main/private Obsidian vault is never scanned by default.
- Bootstrap scripts do not edit global Claude or Codex settings automatically.
- Real work-log data should stay local, encrypted, or privately synced outside this repo.

Read [SECURITY.md](SECURITY.md) before enabling hooks or sharing logs across machines.
