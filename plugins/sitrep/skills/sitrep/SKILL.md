---
name: sitrep
description: Use when the user wants a visual overview, big picture, map, dashboard or situation report of everything that is open (decisions, questions, risks, concerns, blockers, dependencies), or says "show me the situation", "what's the state of things", "visualize this". Builds a temporary HTML report instead of a text list.
---

# Sitrep

Show the whole situation at a glance for a visual thinker with ADHD. Output is a temporary, self-contained HTML page: summary tiles, a "start here" card, a priority matrix, a dependency map and expandable cards. It is never committed and is deleted when no longer needed.

## 1. Collect silently

Gather every open item from the conversation, tool output, notes and files in scope: decisions, questions, clarifications, concerns, risks, blockers, unverified assumptions. Dedupe and merge overlaps. Note which items must be settled before others (`dependsOn`).

Rate each item **impact** and **urgency** from 1 (low) to 3 (high). Pick the single best next action for the "start here" card: blockers and items that unlock others first.

Keep text short: titles of a few words, `detail` one or two sentences. If there are more than about 15 items, merge small ones or mark minor ones `parked`.

## 2. Build the report

1. Create the temp dir (also sweeps stale ones): `"${CLAUDE_SKILL_DIR}/scripts/report.sh" new`. It prints the directory path, referred to below as `DIR`. It contains `index.html`.
2. Write `DIR/data.js` defining `window.SITREP`. Format and a full example are in [schema.md](schema.md). Write data only; do not edit `index.html`.
3. Reuse the same `DIR` when regenerating in the same session; overwrite `data.js`. Do not write the report anywhere else, and never into the project, a repo or an artifact.

The template renders all text safely (no HTML interpretation), so item text may contain anything. Never put secrets or credentials in the data.

## 3. Open it

Try to open it: `open "DIR/index.html"` (macOS), `xdg-open` (Linux) or `start` (Windows). Opening apps is often blocked in a sandbox. If it fails, do not retry with the sandbox disabled. Instead print the absolute path and a ready-to-run line, and tell the user to run it with the `!` prefix:

```
! open "DIR/index.html"
```

Then give a 2 to 3 line spoken summary of the situation (counts, the "start here" item) and offer to walk through the items one at a time if they have an `oaat`-style flow available. Do not paste the item list into chat.

## 4. Clean up

When the user says they are done, or the session ends, delete the report: `"${CLAUDE_SKILL_DIR}/scripts/report.sh" clean DIR`. The script refuses to delete anything that is not a `sitrep.*` directory directly under the temp dir. If the user answers or resolves items, offer to regenerate the report rather than editing it by hand.
