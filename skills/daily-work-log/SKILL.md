---
name: daily-work-log
description: Generate Obsidian-ready daily work logs from redacted Claude Code, Codex, or other AI coding assistant captures in a private AI work-log vault.
---

# Daily Work Log

## Overview

Generate one structured daily work log from the current day's exported conversations and manual notes. Keep the workflow reusable between Claude Code and Codex by using only portable folder conventions and markdown files.

Use `capture-work-session` earlier in the day to create redacted session captures in the inbox. This skill consumes those captures and creates the final daily work log.

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

Manual note input path:

```text
<work-log-root>/inbox/YYYY/MM/DD/notes/
```

Use the user's local date unless the user gives another date.

## Input Rules

Use only these sources:

- Current conversation context.
- Files in today's `inbox/YYYY/MM/DD/conversations/`.
- Files in today's `inbox/YYYY/MM/DD/notes/`.
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
3. Read today's conversation captures and manual notes.
4. Identify distinct work conversations, projects, incidents, decisions, commands, errors, fixes, and follow-ups.
5. Extract durable knowledge into two types:
   - `Notes`: what was learned, decided, discovered, or clarified.
   - `Steps`: how to repeat a process or solve a problem.
6. Generate or update the daily markdown log.
7. Preserve manually edited content if the output file already exists.
8. Report the output path and any missing input assumptions.

## Output Format

Use this top-level structure:

```markdown
---
status: generated
needs_review: true
---

# Work Daily Log - YYYY-MM-DD

## Work Log

- **<<Project or Workstream>> (<<Assistant>>; <<Topic>>)**: Did the following: #work/log #ai/claude
	- ...

- **<<Project or Workstream>> (<<Assistant>>; <<Topic>>)**: Learnt the following: #work/log #ai/claude

	- ==<<Technology or Domain>> - Notes - <<Specific Note Name>>== #work/learn #ai/claude
		- Notes
			- ...

	- ==<<Technology or Domain>> - Steps - <<Specific Procedure Name>>== #work/learn #ai/claude
		- Steps
			1. ...
			2. ...
```

Agent tag rules:

- Use `#ai/claude` when the source is Claude Code.
- Use `#ai/codex` when the source is Codex.
- Use both tags only when both agents materially contributed to the same item.
- Treat source `candidate_tags` as hints, not as authoritative taxonomy.

Keep work logs separate from personal logs:

- Work event tags: `#work/log`
- Work learning tags: `#work/learn`
- Personal event tags are not used by this skill.

## Extraction Rules

Include:

- Completed work.
- Meaningful decisions.
- Bugs, incidents, root causes, and fixes.
- Commands that matter for repeatability.
- Setup or environment lessons.
- Reusable troubleshooting steps.
- Follow-ups and unresolved blockers.

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
