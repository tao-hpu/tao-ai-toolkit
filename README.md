# tao-ai-toolkit

[中文文档](./README_zh.md)

A collection of specialized AI coding agents and commands by [@tao-hpu](https://github.com/tao-hpu).

## Features

### Agents

| Agent | Description |
|-------|-------------|
| `tao-react-motion` | SVG illustration & animation specialist using Framer Motion |
| `tao-doc-writer-zh` | Chinese technical documentation writer |
| `tao-drawio-vector-illustration-generator` | DrawIO diagram generator for workflows and architectures |
| `tao-md-editor-master` | Markdown table and document editor |
| `tao-proposal-expansion-expert` | Expands brief points into detailed proposal paragraphs |

### Commands

| Command | Description |
|---------|-------------|
| `tao-paper-analysis` | Academic paper layout and format checker |
| `tao-paper-review` | Deep paper review with quality assessment |

## Installation

### Quick Install (Claude Code)

```bash
git clone https://github.com/tao-hpu/tao-ai-toolkit.git
cd tao-ai-toolkit
./install.sh
```

### Manual Install

Symlink agents to your Claude Code config:

```bash
ln -sf /path/to/tao-ai-toolkit/src/agents/*.md ~/.claude/agents/
```

### One-liner

```bash
git clone https://github.com/tao-hpu/tao-ai-toolkit.git ~/.tao-ai-toolkit && ~/.tao-ai-toolkit/install.sh --claude
```

## Usage

### Claude Code

Once installed, the agents are available as sub-agents:

```
Launch tao-react-motion agent to create a RAG system illustration
```

Or use the Task tool directly:

```
Task tool with subagent_type="tao-react-motion"
```

## Supported Tools

| Tool | Status | Config Location |
|------|--------|-----------------|
| Claude Code | ✅ Full support | `~/.claude/agents/` |
| Cursor | 🔜 Planned | `~/.cursor/rules/` |
| Windsurf | 🔜 Planned | `~/.windsurfrules` |
| GitHub Copilot | 🔜 Planned | `.github/copilot-instructions.md` |

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
rm ~/.claude/commands/tao-*.md
```

## Structure

```
tao-ai-toolkit/
├── src/
│   ├── agents/          # Sub-agent definitions
│   │   └── tao-react-motion.md
│   └── commands/        # Slash commands
├── install.sh           # Installation script
└── README.md
```

## Contributing

Contributions welcome! Please follow the naming convention:

- Agents: `tao-{name}.md`
- Commands: `tao-{name}.md`

## License

MIT
