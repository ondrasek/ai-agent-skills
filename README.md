# ai-agent-skills

Personal collection of AI agent skills, packaged as a [Claude Code plugin marketplace](https://code.claude.com/docs/en/plugin-marketplaces).

## Install

```
/plugin marketplace add ondrasek/ai-agent-skills
/plugin install <plugin>@ondrasek-skills
```

On Claude Code 2.1.275+ this works in one step, e.g. `/plugin install oaat --marketplace ondrasek/ai-agent-skills`

## Layout

```
.claude-plugin/marketplace.json     # marketplace catalog (lists every plugin)
plugins/<plugin>/
  .claude-plugin/plugin.json        # plugin manifest
  skills/<skill>/SKILL.md           # one directory per skill
```

Each plugin groups related skills. Add `agents/`, `commands/`, `hooks/` or `.mcp.json` inside a plugin when needed.

## Adding a plugin

1. Copy an existing plugin (e.g. `plugins/oaat`) to `plugins/<name>` and edit `plugin.json`.
2. Add skills under `plugins/<name>/skills/<skill>/SKILL.md`.
3. Register the plugin in `.claude-plugin/marketplace.json`.
4. Run `claude plugin validate .`

## Plugins

| Plugin | Description |
| --- | --- |
| `oaat` | Walks through pending decisions, questions and risks strictly one at a time (ADHD-friendly). Invoke with `/oaat` or `/oaat:oaat`. |
