# Inbox

Store daily source material here before running the daily work-log skill.

Use this nested date layout:

```text
YYYY/MM/DD/conversations/
YYYY/MM/DD/notes/
YYYY/MM/DD/automations/<automation-id>/
```

Conversation captures go in `conversations/`.

Manual notes, reminders, and extra context go in `notes/`.

Automation digests, heartbeat outputs, and scheduled research summaries go in `automations/<automation-id>/`.

Preferred capture flow:

1. Use `capture-work-session` near the end of an AI coding assistant session.
2. Confirm it writes a redacted markdown capture into `YYYY/MM/DD/conversations/`.
3. Use `automation-vault-sync` to save automation digests into `YYYY/MM/DD/automations/<automation-id>/`.
4. Add any extra human notes into `YYYY/MM/DD/notes/`.
5. Run `daily-work-log` at the end of the day to create the generated Obsidian-ready log.

Avoid putting raw transcripts here when they may contain secrets, credentials, tokens, or sensitive customer/private data.
