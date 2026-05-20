# macOS Setup

## Recommended Locations

```text
Tool repo:      ~/Documents/a-ai-codex/ai-work-log-bootstrap/
Work-log vault: ~/Documents/a-ai-obsidian-vaults/ai-work-logs/
Main vault:     <private Obsidian vault, not scanned by assistants>
```

## Clone The Setup Repo

```bash
mkdir -p "$HOME/Documents/a-ai-codex"
git clone git@github.com:jcsnorlax97/ai-work-log-bootstrap.git "$HOME/Documents/a-ai-codex/ai-work-log-bootstrap"
```

## Bootstrap The Work-Log Vault

```bash
cd "$HOME/Documents/a-ai-codex/ai-work-log-bootstrap"
zsh bootstrap/macos/bootstrap-ai-work-log-vault.sh "$HOME/Documents/a-ai-obsidian-vaults/ai-work-logs"
```

The script creates the private work-log vault and copies templates/hooks. It does not modify your private/main Obsidian vault.

## Verify

```bash
find "$HOME/Documents/a-ai-obsidian-vaults/ai-work-logs" -maxdepth 3 -type d
python3 -m py_compile "$HOME/Documents/a-ai-obsidian-vaults/ai-work-logs/hooks/capture_session_end.py"
```

Expected inbox source types:

```text
inbox/YYYY/MM/DD/conversations/
inbox/YYYY/MM/DD/notes/
inbox/YYYY/MM/DD/automations/
```

## Obsidian

Open this folder as a separate lightweight vault:

```text
~/Documents/a-ai-obsidian-vaults/ai-work-logs
```

Do not point assistants at your private/main vault.
