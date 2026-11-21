#!/usr/bin/env bash
# SessionStart (startup|resume): make sure graphify is available, git hooks are in
# place, and the knowledge graph matches the working tree. Prints a one-line status
# that Claude Code adds to the session context. Never fails the session.
GRAPHIFY_VERSION="0.9.114"
cd "${CLAUDE_PROJECT_DIR:-$(pwd)}" 2>/dev/null || exit 0
export PATH="$HOME/.local/bin:$PATH"
export GRAPHIFY_BACKEND=none   # code-only: never send source to an LLM backend from hooks

# 1. Install graphify in cloud sessions (containers are ephemeral). Locally, only advise.
if ! command -v graphify >/dev/null 2>&1; then
  if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ] && command -v uv >/dev/null 2>&1; then
    uv tool install --quiet "graphifyy==${GRAPHIFY_VERSION}" >/dev/null 2>&1
  fi
fi
if ! command -v graphify >/dev/null 2>&1; then
  echo "graphify: not installed. Install with: uv tool install graphifyy==${GRAPHIFY_VERSION} (graph tools unavailable; fall back to normal search)."
  exit 0
fi

# 2. Git hooks (.git/hooks is per-clone, not versioned): install once if missing.
if [ -d .git ] && ! graphify hook status 2>/dev/null | grep -q "post-commit: installed"; then
  graphify hook install >/dev/null 2>&1
fi

# 3. Freshness: rebuild incrementally if the graph is missing or behind HEAD / the working tree.
G=graphify-out/graph.json
state="fresh"
if [ ! -f "$G" ]; then
  graphify extract . --code-only >/dev/null 2>&1 && graphify cluster-only . --no-label --no-viz >/dev/null 2>&1
  state="built"
else
  built=$(python3 -c "import json;print(json.load(open('$G')).get('built_at_commit') or '')" 2>/dev/null)
  head=$(git rev-parse HEAD 2>/dev/null)
  dirty=$(git status --porcelain --untracked-files=normal -- . ':!graphify-out' 2>/dev/null | head -1)
  if [ -n "$head" ] && { [ "${built:0:7}" != "${head:0:7}" ] || [ -n "$dirty" ]; }; then
    graphify update . >/dev/null 2>&1 && state="updated" || state="stale (update failed)"
  fi
fi

stats=$(python3 -c "import json;g=json.load(open('$G'));print(f\"{len(g['nodes'])} nodes, {len(g['links'])} edges, commit {(g.get('built_at_commit') or '?')[:8]}\")" 2>/dev/null)
echo "graphify: knowledge graph ${state} (${stats}). Start codebase questions with: graphify query \"<question>\" | graphify explain \"<symbol>\" | graphify path \"<A>\" \"<B>\". Overview: graphify-out/GRAPH_REPORT.md."
exit 0
