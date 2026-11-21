#!/usr/bin/env bash
# Portable wrapper for graphify's Claude Code hooks (PreToolUse / SessionStart:compact).
# `graphify claude install` writes an absolute exe path that only exists on the machine
# that ran it; this wrapper resolves graphify at run time instead and fails open
# (exit 0, no output) when it is not installed, so hooks never block work.
for c in "$(command -v graphify 2>/dev/null)" "$HOME/.local/bin/graphify"; do
  if [ -n "$c" ] && [ -x "$c" ]; then exec "$c" "$@"; fi
done
exit 0
