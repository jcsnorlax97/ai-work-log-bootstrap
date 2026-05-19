#!/usr/bin/env python3
"""
Capture Claude Code SessionEnd hook metadata into the private AI work-log vault.

This script is intentionally conservative:
- It writes a small markdown index file into today's conversations inbox.
- It does not copy raw transcripts unless WORK_DAILY_LOG_COPY_RAW_TRANSCRIPT=1.
- It does not summarize the transcript; run the daily-work-log skill at end of day.

Install by pointing a Claude Code SessionEnd hook at this script and setting:

AI_WORK_LOG_ROOT=/absolute/path/to/ai-work-logs

Legacy env var also works:

WORK_DAILY_LOG_ROOT=/absolute/path/to/ai-work-logs
"""

from __future__ import annotations

import json
import os
import re
import shutil
import sys
from datetime import datetime
from pathlib import Path


def sanitize(value: str) -> str:
    value = value.strip().lower() or "unknown-project"
    value = re.sub(r"[^a-z0-9._-]+", "-", value)
    value = value.strip("-._")
    return value[:80] or "unknown-project"


def truthy_env(name: str) -> bool:
    return os.environ.get(name, "").strip().lower() in {"1", "true", "yes", "on"}


def checked_root(path: Path) -> Path:
    expanded = path.expanduser()
    if expanded.exists() and expanded.is_symlink():
        raise RuntimeError(f"work-log root must not be a symlink: {expanded}")
    return expanded.resolve()


def find_root() -> Path:
    configured = os.environ.get("AI_WORK_LOG_ROOT") or os.environ.get("WORK_DAILY_LOG_ROOT")
    if configured:
        return checked_root(Path(configured))

    cwd = Path.cwd().resolve()
    for candidate in [cwd, *cwd.parents]:
        for root in (
            candidate / "ai-work-logs",
            candidate / "work_daily_logs",
        ):
            if root.exists():
                return checked_root(root)

    raise RuntimeError("AI_WORK_LOG_ROOT is not set and no work-log root was found")


def main() -> int:
    raw = sys.stdin.read()
    event = json.loads(raw or "{}")

    root = find_root()
    now = datetime.now()
    date_path = root / "inbox" / f"{now:%Y}" / f"{now:%m}" / f"{now:%d}" / "conversations"
    date_path.mkdir(parents=True, exist_ok=True)

    cwd = Path(event.get("cwd") or ".").expanduser()
    project = sanitize(cwd.name)
    session_id = sanitize(event.get("session_id") or "session")
    reason = event.get("reason") or "unknown"
    transcript = Path(event.get("transcript_path") or "").expanduser()
    copy_raw_transcript = truthy_env("WORK_DAILY_LOG_COPY_RAW_TRANSCRIPT")

    base_name = f"claude-code-{project}-{session_id}"
    index_path = date_path / f"{base_name}.md"
    transcript_target = date_path / f"{base_name}.jsonl"

    copied = False
    if copy_raw_transcript and transcript.exists() and transcript.is_file():
        shutil.copyfile(transcript, transcript_target)
        copied = True

    index_path.write_text(
        "\n".join(
            [
                f"# Claude Code Session Capture - {now:%Y-%m-%d}",
                "",
                "Source assistant: Claude Code",
                f"Project: {cwd.name}",
                f"Session ID: {event.get('session_id', '')}",
                f"Exit reason: {reason}",
                f"Working directory: {cwd}",
                f"Raw transcript copy enabled: {'yes' if copy_raw_transcript else 'no'}",
                f"Transcript copied: {'yes' if copied else 'no'}",
                f"Transcript file: {transcript_target.name if copied else '[not copied]'}",
                "",
                "## Notes",
                "",
                "- This file was created by the Claude Code SessionEnd hook.",
                "- Use the `capture-work-session` skill for summarized, redacted session captures.",
                "- Run the `daily-work-log` skill at end of day to summarize reviewed captures.",
                "- Raw transcript copying is disabled by default because transcripts may contain secrets.",
                "",
            ]
        ),
        encoding="utf-8",
    )

    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"daily work log capture failed: {exc}", file=sys.stderr)
        raise SystemExit(1)
