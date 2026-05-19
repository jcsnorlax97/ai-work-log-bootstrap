# Work Daily Log Format

## Date Layout

For May 19, 2026, use:

```text
<work-log-root>/
  inbox/2026/05/19/
    conversations/
    notes/
  generated/2026/05/2026-05-19.md
```

Recommended production roots:

```text
macOS:   ~/Documents/a-ai-obsidian-vaults/ai-work-logs/
Windows: %USERPROFILE%\Documents\a-ai-obsidian-vaults\ai-work-logs\
```

Keep this root separate from the setup repo and from the user's private/main Obsidian vault.

## Conversation File Naming

Prefer descriptive names:

```text
claude-code-api-debugging.md
codex-backend-refactor.md
manual-followups.md
```

If the source has timestamps, keep them in the file content. Do not depend on filename timestamps only.

Preferred source files are redacted markdown captures created by `capture-work-session`. Raw transcripts should be used only for low-risk work and should be reviewed for secrets before daily log generation.

## Daily Output Skeleton

```markdown
---
status: generated
needs_review: true
---

# Work Daily Log - YYYY-MM-DD

## Work Log

- **Project Name (Claude Code; Short Topic)**: Did the following: #work/log #ai/claude
	- ...

- **Project Name (Claude Code; Short Topic)**: Learnt the following: #work/log #ai/claude

	- ==Technology - Notes - Specific Learning== #work/learn #ai/claude
		- Notes
			- ...

	- ==Technology - Steps - Repeatable Procedure== #work/learn #ai/claude
		- Steps
			1. ...
			2. ...

## Follow-ups

- ...
```

## Note Type Rules

Use `Notes` for:

- Concepts.
- Decisions.
- Findings.
- Root causes.
- Design constraints.
- Lessons learned.

Use `Steps` for:

- Repeatable procedures.
- Debugging recipes.
- Setup flows.
- Deployment commands.
- Verification checklists.

## Project Naming

Use the most specific stable name available:

- Repository name.
- Issue key if present.
- Customer/project/service name if the conversation clearly centers on it.
- `General Work` only if no better project name exists.

## Assistant Naming

Use:

- `Claude Code` for Claude Code conversations.
- `Codex` for Codex conversations.
- `Claude Code + Codex` only when both contributed to the same work item.

## Privacy And Safety

Before writing the generated log:

- Remove secrets, credentials, tokens, API keys, cookies, private URLs, and customer private data.
- Replace sensitive values with `[redacted]`.
- Keep only enough technical detail to make the lesson useful.
- Do not include full stack traces unless a short excerpt is necessary.
