---
name: daily-work-log
description: Generate Obsidian-ready daily logs from redacted AI assistant captures, input notes, manual notes, and automation digests in a private AI work-log vault.
---

# Daily Work Log

## Overview

Generate one structured daily work log from the current day's exported
conversations, source notes, and automation digests. Keep the workflow reusable
between Claude Code and Codex by using only portable folder conventions and
markdown files.

Use `capture-assistant-session` earlier in the day to create redacted session captures in the inbox. Use `capture-input-note` for external source material, and use `automation-vault-sync` to save reviewed automation digests into the same day's inbox. This skill consumes those sources and creates the final daily log.

## Folder Contract

Resolve the work-log root in this order:

1. A path explicitly provided by the user.
2. `AI_WORK_LOG_ROOT`, if available.
3. `WORK_DAILY_LOG_ROOT`, if available.
4. A nearby `ai-work-logs/` folder.
5. A nearby `work_daily_logs/` folder only as a compatibility fallback.

Recommended production roots:

```text
macOS:   ~/Documents/a-ai-obsidian-vaults/ai-work-logs/
Windows: %USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs\
```

Use this folder structure under the resolved work-log root:

```text
<work-log-root>/
  inbox/YYYY/MM/DD/conversations/
  inbox/YYYY/MM/DD/notes/
  inbox/YYYY/MM/DD/automations/<automation-id>/
  generated/YYYY/MM/
```

Generated output path:

```text
<work-log-root>/generated/YYYY/MM/YYYY-MM-DD.md
```

Conversation input path:

```text
<work-log-root>/inbox/YYYY/MM/DD/conversations/
```

Source note input path:

```text
<work-log-root>/inbox/YYYY/MM/DD/notes/
```

Automation digest input path:

```text
<work-log-root>/inbox/YYYY/MM/DD/automations/
```

Use the user's local date unless the user gives another date.

## Input Rules

Use only these sources:

- Current conversation context.
- Files in today's `inbox/YYYY/MM/DD/conversations/`.
- Files in today's `inbox/YYYY/MM/DD/notes/`.
- Files in today's `inbox/YYYY/MM/DD/automations/<automation-id>/`.
- Specific files the user explicitly asks you to include.

Do not inspect the user's private/main Obsidian vault root. Do not scan unrelated home directories, parent folders, hidden application history, or assistant transcript stores. Do not follow symlinks, shortcuts, or junctions from the work-log root into private vaults or unrelated folders.

Supported input formats:

- `.md`
- `.txt`
- `.json`
- `.jsonl`
- `.log`

Raw transcript formats such as `.jsonl` should be used only when the user explicitly confirms they are low risk and reviewed. Prefer redacted markdown captures.

Ignore generated logs when gathering inputs, unless the user asks to revise an existing generated log.

## Workflow

1. Resolve the target date.
2. Resolve the work-log root and locate the matching daily inbox and generated output paths.
3. Read today's conversation captures, automation digests, manual notes, and
   input notes.
4. Identify distinct work conversations, automation outputs, projects, incidents, decisions, commands, errors, fixes, and follow-ups.
5. Classify each source with `scope: work | personal | mixed`. Prefer an
   explicit frontmatter `scope`; otherwise infer conservatively from the
   content and mention assumptions.
6. Extract durable knowledge into two types:
   - `Notes`: what was learned, decided, discovered, or clarified.
   - `Steps`: how to repeat a process or solve a problem.
7. Generate or update the daily markdown log.
8. Preserve manually edited content if the output file already exists.
9. Report the output path and any missing input assumptions.

## Output Format

Use this top-level structure:

```markdown
---
status: generated
needs_review: true
---

# Work Daily Log - YYYY-MM-DD

## Source Coverage

- Conversations:
	- ...
- Input Notes:
	- ...
- Manual Notes:
	- ...
- Automations:
	- ...

## Work Log

- **<<Project or Workstream>> (<<Assistant>>; <<Topic>>)**: Did the following: #work/log #ai/claude
	- ...

## Learning Candidates

- ==<<Technology or Domain>> - Notes - <<Specific Note Name>>== #work/learn #ai/claude
	- Notes
		- ...

- ==<<Technology or Domain>> - Steps - <<Specific Procedure Name>>== #work/learn #ai/claude
	- Steps
		1. ...
		2. ...

## Review Queue Candidates

- ...

## Follow-ups

- ...
```

Agent tag rules:

- Use `#ai/claude` when the source is Claude Code.
- Use `#ai/codex` when the source is Codex.
- Use both tags only when both agents materially contributed to the same item.
- Treat source `candidate_tags` as hints, not as authoritative taxonomy.

Keep work logs separate from personal logs:

- Work event tags: `#work/log`
- Work learning tags: `#work/learn`
- Personal event tags: `#personal/log`
- Personal learning tags: `#personal/learn`
- Mixed-scope event tags: `#mixed/log`
- Mixed-scope learning tags: `#mixed/learn`
- Use `#mixed/*` when a source materially serves both work and personal systems.

## Extraction Rules

Include:

- Completed work.
- Scheduled automation outputs and reviewed automation digests.
- Meaningful decisions.
- Bugs, incidents, root causes, and fixes.
- Commands that matter for repeatability.
- Setup or environment lessons.
- Reusable troubleshooting steps.
- Follow-ups and unresolved blockers.
- A `Source Coverage` section that lists which conversation captures, input
  notes, manual notes, and automation digests were included.

Exclude:

- Small talk.
- Repeated status chatter.
- Raw terminal output unless the exact line is useful.
- Secrets, tokens, private keys, credentials, customer private data, or sensitive personal data.
- Long copied source code unless needed as a short reference.

## Existing Output Handling

If the generated file already exists:

- Read it first.
- Preserve sections that appear manually edited.
- Append new workstreams or update clearly matching sections.
- Avoid duplicating the same conversation summary.
- Add a short `## Follow-ups` section if unresolved actions exist.

## References

Read `references/work-daily-log-format.md` only when detailed examples or edge cases are needed.
