# Repo Agent Guide

## Communication

- Use traditional Chinese to reply unless the user explicitly asks for another language.
- Prefer concise, direct engineering communication.

## Personal AI OS Roadmap

Before planning work related to AI work logs, capture workflows, daily logs,
automation vault sync, bootstrap scripts, or cross-system roadmap decisions,
read:

```text
/Users/jcsnorlax97/Documents/a-ai-codex/ai-ops-ecosystem-spec/spec/ROADMAP.md
```

Use that roadmap as the current source of truth for how this repo relates to the
Personal AI Operating System.

## Repo Boundary

- This repo owns generic work-log vault contracts, skills, templates, bootstrap
  scripts, and security docs.
- Do not store real work logs, generated daily notes, raw transcripts, private
  Obsidian notes, credentials, or customer/private data here.
- The runtime work-log vault is separate:

```text
/Users/jcsnorlax97/Documents/a-ai-obsidian-vaults/ai-work-logs
```

## Safety

- 禁止批量刪除文件或目錄。
- 不要使用 `del /s`、`rd /s`、`rmdir /s`、`Remove-Item -Recurse`、`rm -rf`。
- 如需刪除文件，只能一次刪除一個明確路徑的文件。
- 如果需要批量刪除，停止並請用戶手動處理。
