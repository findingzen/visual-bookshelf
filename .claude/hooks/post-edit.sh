#!/usr/bin/env bash
# PostToolUse hook for Edit|Write|MultiEdit.
#   1. Reject files with CRLF line endings (exit 2 feeds the message back to Claude).
#   2. Format Python files with ruff, if ruff can be found.
# Project-agnostic on purpose, so it can move to ~/.claude/hooks/ unchanged.
set -euo pipefail

file=$(python3 -c 'import json, sys
d = json.load(sys.stdin)
print(d.get("tool_input", {}).get("file_path") or d.get("tool_response", {}).get("filePath") or "")')

[[ -n "$file" && -f "$file" ]] || exit 0

# Binary files and files git marks as binary or eol=crlf are left alone.
if git -C "$(dirname "$file")" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  attrs=$(git -C "$(dirname "$file")" check-attr binary eol -- "$file")
  if grep -qE 'binary: set|eol: crlf' <<<"$attrs"; then
    exit 0
  fi
fi
grep -qI . "$file" 2>/dev/null || exit 0

if grep -q $'\r' "$file"; then
  echo "CRLF line endings in $file. This repo requires LF; rewrite the file with LF endings." >&2
  exit 2
fi

if [[ "$file" == *.py ]]; then
  # Prefer the nearest project venv's ruff, then one on PATH.
  ruff=""
  dir=$(dirname "$file")
  while [[ "$dir" != "/" ]]; do
    if [[ -x "$dir/.venv/bin/ruff" ]]; then ruff="$dir/.venv/bin/ruff"; break; fi
    dir=$(dirname "$dir")
  done
  [[ -z "$ruff" ]] && ruff=$(command -v ruff || true)
  if [[ -n "$ruff" ]]; then
    "$ruff" format --quiet "$file" || echo "ruff format failed on $file" >&2
  fi
fi
exit 0
