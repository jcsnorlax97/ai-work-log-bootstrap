# Windows Setup

## Recommended Locations

```text
Tool repo:      C:\work\ai-work-log-bootstrap\
Work-log vault: %USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs\
Main vault:     <private Obsidian vault, not scanned by assistants>
```

## Clone The Setup Repo

```powershell
git clone git@github.com:jcsnorlax97/ai-work-log-bootstrap.git C:\work\ai-work-log-bootstrap
```

## Bootstrap The Work-Log Vault

```powershell
cd C:\work\ai-work-log-bootstrap
PowerShell -ExecutionPolicy Bypass -File .\bootstrap\windows\bootstrap-ai-work-log-vault.ps1 -VaultRoot "$env:USERPROFILE\Documents\a-ai-obsidian-vaults\ai-work-logs"
```

The script creates the private work-log vault and copies templates/hooks. It does not modify your private/main Obsidian vault.

## Verify

```powershell
Get-ChildItem "$env:USERPROFILE\Documents\a-ai-obsidian-vaults\ai-work-logs" -Directory
python -m py_compile "$env:USERPROFILE\Documents\a-ai-obsidian-vaults\ai-work-logs\hooks\capture_session_end.py"
```

## Obsidian

Open this folder as a separate lightweight vault:

```text
%USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs
```

Do not point assistants at your private/main vault.
