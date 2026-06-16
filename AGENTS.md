# Repo Agent Guide

## Communication

- Use traditional Chinese to reply unless the user explicitly asks for another language.
- Prefer concise, direct engineering communication.

<!-- BEGIN portable-agent-baseline:karpathy-principles v0.1.0 -->
## Portable Agent Baseline: Karpathy Principles

- Think before coding: state assumptions, surface ambiguity, and ask when the safe interpretation is unclear.
- Simplicity first: prefer the smallest design that satisfies the request; avoid speculative abstractions or extra configuration.
- Surgical changes: touch only files and lines needed for the task, match local style, and mention unrelated concerns instead of editing them.
- Goal-driven execution: turn open-ended work into success criteria and verify the result with tests, scripts, inspection, or another concrete check.

Apply this baseline before ordinary implementation habits, but never use it to override explicit user instructions, safety rules, privacy boundaries, or stricter repo-local instructions.
<!-- END portable-agent-baseline:karpathy-principles -->

## Personal AI OS Roadmap

Before planning work related to AI work logs, capture workflows, daily logs,
automation vault sync, bootstrap scripts, or cross-system roadmap decisions,
read:

```text
/Users/jcsnorlax97/Documents/a-ai-codex/ai-ops-ecosystem-spec/spec/ROADMAP.md
```

Use that roadmap as the current source of truth for how this repo relates to the
Personal AI Operating System.

Before cross-repo AI OS work, run the central freshness check from the standard
sibling repo:

```text
../ai-ops-ecosystem-spec/scripts/check-ecosystem-repos.sh --fetch
```

Before introducing a new capture `routing_class`, `source_type`, alias, or
broadly reused `domain`, query the central registry:

```text
python3 ../ai-ops-ecosystem-spec/scripts/list-capture-vocabulary.py
```

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
