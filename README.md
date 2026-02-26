# tao-ai-toolkit

A collection of specialized AI coding agents and skills by [@tao-hpu](https://github.com/tao-hpu).

## Features

### Agents (Independent Context)

Heavy-duty specialists that run in isolated sub-contexts via the Task tool. Best for tasks that generate large outputs or require autonomous exploration.

| Agent | Description |
|-------|-------------|
| `tao-react-motion` | SVG illustration & animation specialist using Framer Motion |
| `tao-drawio-vector-illustration-generator` | DrawIO diagram generator for workflows and architectures |
| `tao-md-editor-master` | Markdown table and document editor |
| `tao-corporate-site-audit` | Corporate website quality auditor for SEO, a11y, performance |

### Skills (Interactive + Auto-invocable)

Interactive specialists that run in the main conversation. Supports `/slash-command` invocation and automatic Claude invocation.

| Skill | Description |
|-------|-------------|
| `tao-credit-card-analyzer` | Credit card statement analysis: categorization + trends + budgeting |
| `tao-contract-review-specialist` | Professional contract review for legal documents |
| `tao-doc-writer-zh` | Chinese technical documentation writer |
| `tao-proposal-expansion-expert` | Expands brief points into detailed proposal paragraphs |
| `tao-paper-analysis` | Academic paper layout and format checker |
| `tao-paper-review` | Deep paper review with quality assessment |

### When to Use What

| Scenario | Use |
|----------|-----|
| Large output (SVG, DrawIO XML, full audit) | **Agent** - keeps main context clean |
| Need mid-task interaction with user | **Skill** - runs in conversation |
| Want `/slash-command` quick access | **Skill** - supports `/name` |
| Parallel independent tasks | **Agent** - can run multiple simultaneously |

## Installation

### Quick Install (Claude Code)

```bash
git clone https://github.com/tao-hpu/tao-ai-toolkit.git
cd tao-ai-toolkit
./install.sh
```

### Manual Install

```bash
# Agents
ln -sf /path/to/tao-ai-toolkit/src/agents/*.md ~/.claude/agents/

# Skills (symlink each directory)
for skill in /path/to/tao-ai-toolkit/src/skills/*/; do
    ln -sf "$skill" ~/.claude/skills/$(basename "$skill")
done
```

### One-liner

```bash
git clone https://github.com/tao-hpu/tao-ai-toolkit.git ~/.tao-ai-toolkit && ~/.tao-ai-toolkit/install.sh --claude
```

## Usage

### Agents (via Task tool or natural language)

```
Launch tao-react-motion agent to create a RAG system illustration
```

### Skills (via slash command or natural language)

```
/tao-credit-card-analyzer
Analyze /path/to/credit-card-statement.pdf
```

```
/tao-paper-review
https://arxiv.org/abs/2401.12345
```

## Supported Tools

| Tool | Status | Config Location |
|------|--------|-----------------|
| Claude Code | Full support | `~/.claude/agents/` + `~/.claude/skills/` |
| Cursor | Planned | `~/.cursor/rules/` |
| Windsurf | Planned | `~/.windsurfrules` |
| GitHub Copilot | Planned | `.github/copilot-instructions.md` |

## Update

```bash
cd /path/to/tao-ai-toolkit
git pull
./install.sh --claude  # Re-link if needed
```

Since we use symlinks, most updates take effect immediately after `git pull`.

## Uninstall

```bash
./install.sh --uninstall
```

Or manually remove symlinks:

```bash
rm ~/.claude/agents/tao-*.md
rm -rf ~/.claude/skills/tao-*
```

## Structure

```
tao-ai-toolkit/
├── src/
│   ├── agents/                                    # Sub-agents (isolated context)
│   │   ├── tao-corporate-site-audit.md
│   │   ├── tao-drawio-vector-illustration-generator.md
│   │   ├── tao-md-editor-master.md
│   │   └── tao-react-motion.md
│   └── skills/                                    # Skills (interactive, /slash-command)
│       ├── tao-contract-review-specialist/
│       │   └── SKILL.md
│       ├── tao-credit-card-analyzer/
│       │   └── SKILL.md
│       ├── tao-doc-writer-zh/
│       │   └── SKILL.md
│       ├── tao-paper-analysis/
│       │   └── SKILL.md
│       ├── tao-paper-review/
│       │   └── SKILL.md
│       └── tao-proposal-expansion-expert/
│           └── SKILL.md
├── .gitignore
├── CLAUDE.md
├── install.sh
└── README.md
```

## Contributing

Contributions welcome! Follow the naming convention:

- Agents: `src/agents/tao-{name}.md`
- Skills: `src/skills/tao-{name}/SKILL.md`

## License

MIT
