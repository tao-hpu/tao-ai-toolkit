# tao-ai-toolkit

[English](./README.md)

由 [@tao-hpu](https://github.com/tao-hpu) 打造的专业 AI 编程代理与命令集合。

## 功能特性

### 代理 (Agents)

| 代理名称 | 功能描述 |
|---------|----------|
| `tao-react-motion` | SVG 插图与动画专家，使用 Framer Motion |
| `tao-doc-writer-zh` | 中文技术文档写作专家 |
| `tao-drawio-vector-illustration-generator` | DrawIO 图表生成器，用于工作流和架构图 |
| `tao-md-editor-master` | Markdown 表格与文档编辑专家 |
| `tao-proposal-expansion-expert` | 申报书扩写专家，将简要要点扩展为详细段落 |
| `tao-corporate-site-audit` | 企业官网质量审计，检查 SEO、可访问性、性能 |

### 命令 (Commands)

| 命令名称 | 功能描述 |
|---------|----------|
| `tao-paper-analysis` | 学术论文排版与格式检查 |
| `tao-paper-review` | 深度论文审稿，含质量评估 |

## 安装方法

### 快速安装 (Claude Code)

```bash
git clone https://github.com/tao-hpu/tao-ai-toolkit.git
cd tao-ai-toolkit
./install.sh
```

### 手动安装

将代理文件软链接到 Claude Code 配置目录：

```bash
ln -sf /path/to/tao-ai-toolkit/src/agents/*.md ~/.claude/agents/
```

### 一行命令安装

```bash
git clone https://github.com/tao-hpu/tao-ai-toolkit.git ~/.tao-ai-toolkit && ~/.tao-ai-toolkit/install.sh --claude
```

## 使用方法

### Claude Code

安装完成后，代理可作为子代理使用：

```
启动 tao-react-motion 代理来创建一个 RAG 系统插图
```

或直接使用 Task 工具：

```
Task tool with subagent_type="tao-react-motion"
```

## 支持的工具

| 工具 | 状态 | 配置位置 |
|-----|------|---------|
| Claude Code | ✅ 完全支持 | `~/.claude/agents/` |
| Cursor | 🔜 计划中 | `~/.cursor/rules/` |
| Windsurf | 🔜 计划中 | `~/.windsurfrules` |
| GitHub Copilot | 🔜 计划中 | `.github/copilot-instructions.md` |

## 更新方法

```bash
cd /path/to/tao-ai-toolkit
git pull
./install.sh --claude  # 如需要可重新链接
```

由于使用软链接，大多数更新在 `git pull` 后立即生效。

## 卸载方法

```bash
./install.sh --uninstall
```

或手动删除软链接：

```bash
rm ~/.claude/agents/tao-*.md
rm ~/.claude/commands/tao-*.md
```

## 项目结构

```
tao-ai-toolkit/
├── src/
│   ├── agents/                                    # 子代理定义
│   │   ├── tao-corporate-site-audit.md
│   │   ├── tao-doc-writer-zh.md
│   │   ├── tao-drawio-vector-illustration-generator.md
│   │   ├── tao-md-editor-master.md
│   │   ├── tao-proposal-expansion-expert.md
│   │   └── tao-react-motion.md
│   └── commands/                                  # 斜杠命令
│       ├── tao-paper-analysis.md
│       └── tao-paper-review.md
├── .gitignore
├── CLAUDE.md
├── install.sh                                     # 安装脚本
├── README.md
└── README_zh.md
```

## 贡献指南

欢迎贡献！请遵循命名规范：

- 代理：`tao-{name}.md`
- 命令：`tao-{name}.md`

## 开源许可

MIT
