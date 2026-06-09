# Security Model

This repo is safe to share because it should contain only setup material. The AI work-log vault created by these scripts is **not** safe to share publicly and should not be pushed to this repo.

## Boundaries

The safe architecture is:

```text
ai-work-log-bootstrap  -> shared setup/spec repo
ai-work-logs           -> private local work-log vault
private Obsidian vault -> not scanned by coding assistants
```

The filesystem boundary matters more than prompt instructions. Do not rely on "please do not inspect my vault" as the only protection.

## Required Rules

- Do not run Claude Code or Codex from your private/main Obsidian vault.
- Do not run assistants from a parent folder that contains private vaults.
- Do not symlink, shortcut, or junction the AI work-log vault into the private/main vault.
- Do not commit `inbox/`, `generated/`, real captures, raw transcripts, `.jsonl`, or customer/private data to this repo.
- Do not enable raw transcript copying globally.
- Review generated notes before moving them into a private/main vault.

## Capture Modes

| Mode | Default | Risk | Notes |
| --- | --- | --- | --- |
| Manual notes | Enabled | Low | Human-written, reviewable source material. |
| `capture-assistant-session` | Recommended | Medium | Assistant summarizes and redacts, but still requires review. |
| `daily-work-log` | Recommended | Medium | Generates reviewed daily summaries from the private work-log vault. |
| `SessionEnd` metadata hook | Optional | Low | Writes session metadata only by default. |
| Raw transcript copying | Disabled | High | May copy secrets, customer data, private URLs, or confidential context. |

## Raw Transcript Opt-In

The hook copies raw transcripts only when this environment variable is set:

```text
WORK_DAILY_LOG_COPY_RAW_TRANSCRIPT=1
```

Use this only for low-risk sessions where no credentials, customer data, confidential work details, private URLs, or sensitive personal data appear.

## If A Secret Appears

1. Do not capture a raw transcript for that session.
2. Use a summarized redacted capture instead.
3. Review the capture before daily generation.
4. Rotate the exposed credential if it was real.

## Sharing Across Machines

Share this bootstrap repo normally through Git.

Do not share `ai-work-logs` through public GitHub. If you need cross-machine sync for actual work logs, use a private encrypted sync mechanism or keep them local per machine.
