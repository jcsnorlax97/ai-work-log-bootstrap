# Windows Setup

## Recommended Locations

```text
Tool repo:      C:\work\ai-work-log-bootstrap\
Work-log vault: %USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs\
Main vault:     <private Obsidian vault, not scanned by assistants>
```

## Prerequisites

Install Git for Windows and Python 3 before enabling the optional
`SessionEnd` hook. Verify from PowerShell:

```powershell
git --version
winget --info
python --version
py --version
python -m pip --version
```

Python is not required to run the bootstrap script or use the vault manually.
It is required for the optional Python hook.

On Windows, use `python` or `py`; `python3` may resolve to a Microsoft Store
execution alias instead of the installed interpreter.

The recommended Python installation path is the official Python package
installed through `winget` or Python.org, with PATH, `pip`, and the `py`
launcher enabled:

```powershell
winget search --id Python.Python --source winget
winget install --id Python.Python.<major-minor> --exact --source winget
```

Replace `<major-minor>` with the selected stable line. If `winget` cannot
start even though its WindowsApps alias exists, update or reinstall
**App Installer** from Microsoft Store and restart Windows.

## Clone The Setup Repo

```powershell
New-Item -ItemType Directory -Path C:\work -Force | Out-Null
git clone git@github.com:jcsnorlax97/ai-work-log-bootstrap.git C:\work\ai-work-log-bootstrap
```

## Bootstrap The Work-Log Vault

```powershell
cd C:\work\ai-work-log-bootstrap
PowerShell -ExecutionPolicy Bypass -File .\bootstrap\windows\bootstrap-ai-work-log-vault.ps1 -VaultRoot "$env:USERPROFILE\Documents\a-ai-obsidian-vaults\ai-work-logs"
```

The script creates the private work-log vault and copies templates/hooks. It does not modify your private/main Obsidian vault.

Cloning this repository alone does not bootstrap the vault. The bootstrap
script also does not install the work-log skills globally; use the repo-local
skill paths or install them separately as described in the runtime-specific
docs.

## Optional Claude Code Global Memory

Claude Code can load global instructions from:

```text
%USERPROFILE%\.claude\CLAUDE.md
```

Copy or merge the content of this file:

```text
C:\work\ai-work-log-bootstrap\templates\global-CLAUDE.md
```

Then replace placeholder paths with your actual setup repo and work-log vault paths. Do not point this file at your private/main Obsidian vault.

## Verify

```powershell
Get-ChildItem "$env:USERPROFILE\Documents\a-ai-obsidian-vaults\ai-work-logs" -Directory
python -m py_compile "$env:USERPROFILE\Documents\a-ai-obsidian-vaults\ai-work-logs\hooks\capture_session_end.py"
```

Expected inbox source types:

```text
inbox\YYYY\MM\DD\conversations\
inbox\YYYY\MM\DD\notes\
inbox\YYYY\MM\DD\automations\
```

## Claude Code Hook Template

After bootstrapping, use this file as the Windows `SessionEnd` hook reference:

```text
%USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs\templates\claude-settings-hooks.windows.example.json
```

Merge its content into:

```text
%USERPROFILE%\.claude\settings.json
```

Then run `/hooks` inside Claude Code to confirm it is loaded.

## Obsidian

Open this folder as a separate lightweight vault:

```text
%USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs
```

Do not point assistants at your private/main vault.
