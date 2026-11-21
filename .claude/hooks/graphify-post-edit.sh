#!/usr/bin/env bash
# PostToolUse (Edit|Write|MultiEdit): incremental, AST-only graph update after a code edit.
# Skips non-code files and graphify's own output so docs/config edits cost nothing.
cd "${CLAUDE_PROJECT_DIR:-$(pwd)}" 2>/dev/null || exit 0
export PATH="$HOME/.local/bin:$PATH" GRAPHIFY_BACKEND=none
command -v graphify >/dev/null 2>&1 || exit 0
[ -f graphify-out/graph.json ] || exit 0
f=$(python3 -c "import sys,json;print(json.load(sys.stdin).get('tool_input',{}).get('file_path',''))" 2>/dev/null)
case "$f" in
  */graphify-out/*|*/.claude/*|"") exit 0 ;;
  *.astro|*.ts|*.tsx|*.js|*.jsx|*.mjs|*.cjs|*.mts|*.json|*.py|*.go|*.rs|*.vue|*.svelte|*.css|*.yaml|*.yml|*.toml|*.sh) ;;
  *) exit 0 ;;
esac
graphify update . >/dev/null 2>&1 || echo "graphify: incremental update failed after editing $f; run 'graphify update .' manually." >&2
exit 0
