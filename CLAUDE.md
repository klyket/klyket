## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:
- When graphify-out/graph.json exists, run `graphify query "<question>"` before your first grep, search or source-file read for a codebase question, and put this rule in every subagent prompt that explores code. Read raw files only for lines the graph or an earlier read already located. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. When the answer is under a Markdown heading, `graphify section "<heading>"` prints that section's text, so the .md need not be opened. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
- A committed graphify-out/graph.json is rewritten whole on every build, so a large diff to it in a pull request is expected. Do not flag it as churn or suggest skipping the graph rebuild or its hooks.

## Graphify-arbetsprotokoll (klyket)

Kunskapsgrafen är ett första navigeringslager, aldrig källan till sanning. Koden är facit.

**Vid sessionsstart** (automatiskt via `.claude/hooks/graphify-session-start.sh`):
- Hooken installerar graphify (molnsessioner), git-hooks, och kör `graphify update .` om grafen ligger efter HEAD eller arbetskatalogen. Statusraden "graphify: knowledge graph …" i kontexten visar resultatet.
- Om statusraden säger "not installed" eller "stale": arbeta med vanlig sökning och nämn det för användaren.

**Under arbetet**:
- Börja med `graphify query "<fråga>"`, `graphify explain "<symbol>"` eller `graphify path "<A>" "<B>"` för att hitta relevanta filer. Läs sedan bara de filer/rader grafen pekat ut.
- Konsekvensanalys före ändring: `graphify explain "<fil eller symbol>" --all` visar alla in-/utgående kanter (vem importerar/anropar den).
- Läs inte samma fil flera gånger i en session; återanvänd det du redan läst.
- Kanter märkta `EXTRACTED` är lästa direkt ur AST; `INFERRED` är graphifys slutsats och ska verifieras i koden innan du förlitar dig på dem.
- Kända luckor: `.astro`-filers template-del (HTML/JSX-markup, props-användning i markup) modelleras inte som symboler; imports i frontmatter fångas. CSS och README indexeras inte (code-only-läge).

**Efter kodändringar**:
- PostToolUse-hooken kör `graphify update .` efter Edit/Write på kodfiler; git-hooks (post-commit/checkout/merge/rewrite) uppdaterar efter commit.
- Verifiera nya relationer med `graphify explain "<ny symbol>"`. Vid borttagen kod som inte försvinner: `graphify update . --force`.
- Committa `graphify-out/graph.json`, `GRAPH_REPORT.md` och `manifest.json` tillsammans med kodändringen.

**Säkerhet**: Hooks kör med `GRAPHIFY_BACKEND=none` (ingen kod skickas till LLM). `.graphifyignore` exkluderar `.env*`, nycklar, `.netlify/`, `package-lock.json` och tooling-konfig.
