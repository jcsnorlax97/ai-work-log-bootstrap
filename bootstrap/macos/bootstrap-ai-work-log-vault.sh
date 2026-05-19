#!/usr/bin/env bash
set -euo pipefail

target="${1:-"$HOME/Documents/a-ai-obsidian-vaults/ai-work-logs"}"
script_path="${BASH_SOURCE:-$0}"
script_dir="$(cd "$(dirname "$script_path")" && pwd)"
repo_root="$(cd "$script_dir/../.." && pwd)"

copy_if_missing() {
  local source="$1"
  local destination="$2"

  if [[ -e "$destination" ]]; then
    printf 'skip existing: %s\n' "$destination"
    return
  fi

  cp "$source" "$destination"
  printf 'created: %s\n' "$destination"
}

today_year="$(date +%Y)"
today_month="$(date +%m)"
today_day="$(date +%d)"

mkdir -p "$target/inbox/$today_year/$today_month/$today_day/conversations"
mkdir -p "$target/inbox/$today_year/$today_month/$today_day/notes"
mkdir -p "$target/generated"
mkdir -p "$target/templates"
mkdir -p "$target/hooks"

copy_if_missing "$repo_root/templates/vault-README.md" "$target/README.md"
copy_if_missing "$repo_root/templates/inbox-README.md" "$target/inbox/README.md"
copy_if_missing "$repo_root/templates/generated-README.md" "$target/generated/README.md"
copy_if_missing "$repo_root/bootstrap/templates/work-log-vault.gitignore" "$target/.gitignore"

for source in "$repo_root"/templates/*; do
  if [[ -f "$source" ]]; then
    name="$(basename "$source")"
    case "$name" in
      vault-README.md|inbox-README.md|generated-README.md)
        continue
        ;;
    esac
    copy_if_missing "$source" "$target/templates/$name"
  fi
done

copy_if_missing "$repo_root/hooks/capture_session_end.py" "$target/hooks/capture_session_end.py"

printf '\nAI work-log vault initialized at:\n%s\n\n' "$target"
printf 'Use this root with Claude Code or Codex:\n%s\n\n' "$target"
printf 'Example:\n'
printf 'Use $capture-work-session to capture this session into %s.\n' "$target"
