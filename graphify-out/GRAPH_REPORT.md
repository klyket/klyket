# Graph Report - klyket  (2026-11-21)

## Corpus Check
- 16 files · ~2,212 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 5 file(s) not represented in the graph (top: (none) 3, .ico 1, .css 1)

## Summary
- 55 nodes · 72 edges · 10 communities (8 shown, 2 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `650e6d7e`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- rss.ts
- BaseLayout.astro
- scripts
- tsconfig.json
- utils.ts
- astro
- package.json
- dependencies
- fast-xml-parser
- @fontsource/cormorant-garamond

## God Nodes (most connected - your core abstractions)
1. `scripts` - 5 edges
2. `fetchSubstackPosts()` - 4 edges
3. `@astrojs/sitemap` - 3 edges
4. `@fontsource/cormorant-garamond` - 3 edges
5. `@fontsource/karla` - 3 edges
6. `astro` - 3 edges
7. `fast-xml-parser` - 3 edges
8. `SubstackPost` - 3 edges
9. `stripHtml()` - 3 edges
10. `@astrojs/sitemap@^3.7.0` - 2 edges

## Surprising Connections (you probably didn't know these)
- `fetchSubstackPosts()` --calls--> `stripHtml()`  [EXTRACTED]
  src/lib/rss.ts → src/lib/utils.ts

## Import Cycles
- None detected.

## Communities (10 total, 2 thin omitted)

### Community 0 - "rss.ts"
Cohesion: 0.24
Nodes (6): Props, extractCoverImage(), fetchSubstackPosts(), RSSItem, SubstackPost, stripHtml()

### Community 1 - "BaseLayout.astro"
Cohesion: 0.18
Nodes (4): year, navLinks, Props, Props

### Community 2 - "scripts"
Cohesion: 0.40
Nodes (5): scripts, astro, build, dev, preview

### Community 3 - "tsconfig.json"
Cohesion: 0.40
Nodes (4): astro/tsconfigs/strict, exclude, extends, include

### Community 4 - "utils.ts"
Cohesion: 0.60
Nodes (3): Props, formatDate(), truncate()

### Community 5 - "astro"
Cohesion: 0.50
Nodes (3): @astrojs/sitemap@^3.7.0, astro, @astrojs/sitemap

### Community 6 - "package.json"
Cohesion: 0.50
Nodes (3): name, type, version

### Community 7 - "dependencies"
Cohesion: 0.50
Nodes (4): dependencies, astro@^5.17.1, @fontsource/karla@^5.2.8, @fontsource/karla

## Knowledge Gaps
- **1 isolated node(s):** `astro/tsconfigs/strict`
  These have ≤1 connection - possible missing edges. (Counts symbols only; 23 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **2 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `fast-xml-parser` connect `fast-xml-parser` to `rss.ts`, `package.json`?**
  _High betweenness centrality (0.186) - this node is a cross-community bridge._
- **What connects `astro/tsconfigs/strict` to the rest of the system?**
  _1 weakly-connected nodes found - possible missing edges._
- **Why does `scripts` connect `scripts` to `package.json`?**
  _High betweenness centrality (0.130) - this node is a cross-community bridge._
- **Why does `@fontsource/cormorant-garamond` connect `@fontsource/cormorant-garamond` to `BaseLayout.astro`, `package.json`?**
  _High betweenness centrality (0.104) - this node is a cross-community bridge._