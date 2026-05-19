# Codex Setup

## Principle

Use Codex in project repositories or in the bootstrap repo. Do not give Codex broad access to your private/main Obsidian vault.

## Repo-Local Skill Usage

Capture a session:

```text
Use /path/to/ai-work-log-bootstrap/skills/capture-work-session/SKILL.md to capture this session into /path/to/ai-work-logs.
```

Generate an end-of-day note:

```text
Use /path/to/ai-work-log-bootstrap/skills/daily-work-log/SKILL.md to generate today's work daily log from /path/to/ai-work-logs.
```

## Installed Skill Usage

Install the skill folders into Codex's global skills directory:

```text
~/.codex/skills/capture-work-session
~/.codex/skills/daily-work-log
```

Then restart Codex.

After restart:

```text
Use $capture-work-session to capture this session into /path/to/ai-work-logs.
Use $daily-work-log to generate today's work daily log from /path/to/ai-work-logs.
```

## Sandbox Guidance

When possible, grant Codex write access only to:

```text
project repo
ai-work-logs
```

Do not grant default access to:

```text
private/main Obsidian vault
home directory parent folders
assistant history folders
```

## Review

Generated notes should include:

```yaml
needs_review: true
```

Review generated tags and content before copying or linking notes into another vault.
