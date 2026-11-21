# Graph Report - klyket  (2026-11-21)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 55 nodes · 72 edges · 10 communities (8 shown, 2 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `4348c069`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Community 0
- Community 1
- Community 2
- Community 3
- Community 4
- Community 5
- Community 6
- Community 7
- Community 8
- Community 9

## God Nodes (most connected - your core abstractions)
1. `scripts` - 5 edges
2. `fetchSubstackPosts()` - 4 edges
3. `SubstackPost` - 3 edges
4. `stripHtml()` - 3 edges
5. `astro` - 3 edges
6. `@astrojs/sitemap` - 3 edges
7. `@fontsource/karla` - 3 edges
8. `fast-xml-parser` - 3 edges
9. `@fontsource/cormorant-garamond` - 3 edges
10. `RSSItem` - 2 edges

## Surprising Connections (you probably didn't know these)
- `fetchSubstackPosts()` --calls--> `stripHtml()`  [EXTRACTED]
  src/lib/rss.ts → src/lib/utils.ts

## Import Cycles
- None detected.

## Communities (10 total, 2 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.24
Nodes (6): Props, extractCoverImage(), fetchSubstackPosts(), RSSItem, SubstackPost, stripHtml()

### Community 1 - "Community 1"
Cohesion: 0.18
Nodes (4): year, navLinks, Props, Props

### Community 2 - "Community 2"
Cohesion: 0.40
Nodes (5): scripts, astro, build, dev, preview

### Community 3 - "Community 3"
Cohesion: 0.40
Nodes (4): astro/tsconfigs/strict, exclude, extends, include

### Community 4 - "Community 4"
Cohesion: 0.60
Nodes (3): Props, formatDate(), truncate()

### Community 5 - "Community 5"
Cohesion: 0.50
Nodes (3): @astrojs/sitemap@^3.7.0, astro, @astrojs/sitemap

### Community 6 - "Community 6"
Cohesion: 0.50
Nodes (3): name, type, version

### Community 7 - "Community 7"
Cohesion: 0.50
Nodes (4): dependencies, astro@^5.17.1, @fontsource/karla@^5.2.8, @fontsource/karla

## Knowledge Gaps
- **1 isolated node(s):** `astro/tsconfigs/strict`
  These have ≤1 connection - possible missing edges. (Counts symbols only; 23 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **2 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `fast-xml-parser` connect `Community 8` to `Community 0`, `Community 6`?**
  _High betweenness centrality (0.186) - this node is a cross-community bridge._
- **What connects `astro/tsconfigs/strict` to the rest of the system?**
  _1 weakly-connected nodes found - possible missing edges._
- **Why does `scripts` connect `Community 2` to `Community 6`?**
  _High betweenness centrality (0.130) - this node is a cross-community bridge._
- **Why does `@fontsource/karla` connect `Community 7` to `Community 1`, `Community 6`?**
  _High betweenness centrality (0.104) - this node is a cross-community bridge._