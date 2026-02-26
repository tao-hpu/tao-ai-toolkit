#!/bin/bash

# tao-ai-toolkit installer
# Symlinks agents, skills, and commands to your AI coding tool's config directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       tao-ai-toolkit installer         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Detect available tools
detect_tools() {
    local tools=()

    # Claude Code
    if [ -d "$HOME/.claude" ]; then
        tools+=("claude")
    fi

    # Cursor
    if [ -d "$HOME/.cursor" ] || [ -d "$HOME/Library/Application Support/Cursor" ]; then
        tools+=("cursor")
    fi

    # Windsurf
    if [ -d "$HOME/.windsurf" ] || [ -d "$HOME/.codeium" ]; then
        tools+=("windsurf")
    fi

    # GitHub Copilot (check for VS Code)
    if [ -d "$HOME/.vscode" ] || [ -d "$HOME/Library/Application Support/Code" ]; then
        tools+=("copilot")
    fi

    echo "${tools[@]}"
}

# Install for Claude Code
install_claude() {
    echo -e "${BLUE}Installing for Claude Code...${NC}"

    local claude_agents="$HOME/.claude/agents"
    local claude_skills="$HOME/.claude/skills"

    mkdir -p "$claude_agents" "$claude_skills"

    # Link agents (single .md files)
    for file in "$SCRIPT_DIR/src/agents"/*.md; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file")
            local target="$claude_agents/$filename"

            if [ -L "$target" ]; then
                rm "$target"
            fi

            ln -sf "$file" "$target"
            echo -e "  ${GREEN}✓${NC} Linked agent: $filename"
        fi
    done

    # Link skills (directories containing SKILL.md)
    for skill_dir in "$SCRIPT_DIR/src/skills"/*/; do
        if [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ]; then
            local dirname=$(basename "$skill_dir")
            local target="$claude_skills/$dirname"

            if [ -L "$target" ]; then
                rm "$target"
            elif [ -d "$target" ]; then
                rm -rf "$target"
            fi

            ln -sf "$skill_dir" "$target"
            echo -e "  ${GREEN}✓${NC} Linked skill: $dirname"
        fi
    done

    echo -e "${GREEN}Claude Code installation complete!${NC}"
}

# Install for Cursor
install_cursor() {
    echo -e "${BLUE}Installing for Cursor...${NC}"

    local cursor_rules="$HOME/.cursor/rules"
    mkdir -p "$cursor_rules"

    # Link agents as rules
    for file in "$SCRIPT_DIR/src/agents"/*.md; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file" .md)
            local target="$cursor_rules/${filename}.mdc"

            if [ -L "$target" ]; then
                rm "$target"
            fi

            ln -sf "$file" "$target"
            echo -e "  ${GREEN}✓${NC} Linked rule: ${filename}.mdc"
        fi
    done

    # Link skills SKILL.md as rules
    for skill_dir in "$SCRIPT_DIR/src/skills"/*/; do
        if [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ]; then
            local dirname=$(basename "$skill_dir")
            local target="$cursor_rules/${dirname}.mdc"

            if [ -L "$target" ]; then
                rm "$target"
            fi

            ln -sf "$skill_dir/SKILL.md" "$target"
            echo -e "  ${GREEN}✓${NC} Linked rule (skill): ${dirname}.mdc"
        fi
    done

    echo -e "${GREEN}Cursor installation complete!${NC}"
}

# Install for Windsurf
install_windsurf() {
    echo -e "${BLUE}Installing for Windsurf...${NC}"

    local windsurf_rules="$HOME/.windsurf"
    mkdir -p "$windsurf_rules"

    local rules_file="$windsurf_rules/.windsurfrules"

    echo "# tao-ai-toolkit rules" > "$rules_file"
    echo "# Auto-generated - do not edit manually" >> "$rules_file"
    echo "" >> "$rules_file"

    # Include agents
    for file in "$SCRIPT_DIR/src/agents"/*.md; do
        if [ -f "$file" ]; then
            sed '1{/^---$/!q;};1,/^---$/d' "$file" >> "$rules_file"
            echo "" >> "$rules_file"
            echo "---" >> "$rules_file"
            echo "" >> "$rules_file"
        fi
    done

    # Include skills
    for skill_dir in "$SCRIPT_DIR/src/skills"/*/; do
        if [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ]; then
            sed '1{/^---$/!q;};1,/^---$/d' "$skill_dir/SKILL.md" >> "$rules_file"
            echo "" >> "$rules_file"
            echo "---" >> "$rules_file"
            echo "" >> "$rules_file"
        fi
    done

    echo -e "  ${GREEN}✓${NC} Created .windsurfrules"
    echo -e "${GREEN}Windsurf installation complete!${NC}"
}

# Install for GitHub Copilot
install_copilot() {
    echo -e "${BLUE}Installing for GitHub Copilot...${NC}"

    local github_dir=".github"
    local instructions_file="$github_dir/copilot-instructions.md"

    if [ ! -d "$github_dir" ]; then
        echo -e "  ${YELLOW}⚠${NC} No .github directory found in current directory"
        echo -e "  ${YELLOW}⚠${NC} Run this from your project root to install Copilot instructions"
        return
    fi

    echo "# Copilot Instructions" > "$instructions_file"
    echo "# Auto-generated by tao-ai-toolkit" >> "$instructions_file"
    echo "" >> "$instructions_file"

    for file in "$SCRIPT_DIR/src/agents"/*.md; do
        if [ -f "$file" ]; then
            sed '1{/^---$/!q;};1,/^---$/d' "$file" >> "$instructions_file"
            echo "" >> "$instructions_file"
        fi
    done

    for skill_dir in "$SCRIPT_DIR/src/skills"/*/; do
        if [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ]; then
            sed '1{/^---$/!q;};1,/^---$/d' "$skill_dir/SKILL.md" >> "$instructions_file"
            echo "" >> "$instructions_file"
        fi
    done

    echo -e "  ${GREEN}✓${NC} Created copilot-instructions.md"
    echo -e "${GREEN}GitHub Copilot installation complete!${NC}"
}

# Uninstall
uninstall() {
    echo -e "${YELLOW}Uninstalling tao-ai-toolkit...${NC}"

    # Claude Code - agents
    for file in "$HOME/.claude/agents"/tao-*.md; do
        if [ -L "$file" ]; then
            rm "$file"
            echo -e "  ${GREEN}✓${NC} Removed agent: $(basename $file)"
        fi
    done

    # Claude Code - skills
    for dir in "$HOME/.claude/skills"/tao-*/; do
        if [ -L "${dir%/}" ]; then
            rm "${dir%/}"
            echo -e "  ${GREEN}✓${NC} Removed skill: $(basename ${dir%/})"
        fi
    done

    # Claude Code - legacy commands
    for file in "$HOME/.claude/commands"/tao-*.md; do
        if [ -L "$file" ]; then
            rm "$file"
            echo -e "  ${GREEN}✓${NC} Removed command: $(basename $file)"
        fi
    done

    # Cursor
    for file in "$HOME/.cursor/rules"/tao-*.mdc; do
        if [ -L "$file" ]; then
            rm "$file"
            echo -e "  ${GREEN}✓${NC} Removed rule: $(basename $file)"
        fi
    done

    echo -e "${GREEN}Uninstall complete!${NC}"
}

# Show menu
show_menu() {
    echo "Detected tools:"
    local tools=($(detect_tools))

    if [ ${#tools[@]} -eq 0 ]; then
        echo -e "${YELLOW}No supported AI coding tools detected.${NC}"
        echo "Supported tools: Claude Code, Cursor, Windsurf, GitHub Copilot"
        exit 1
    fi

    for tool in "${tools[@]}"; do
        echo -e "  ${GREEN}✓${NC} $tool"
    done
    echo ""

    echo "Options:"
    echo "  1) Install for all detected tools"
    echo "  2) Install for Claude Code only"
    echo "  3) Install for Cursor only"
    echo "  4) Install for Windsurf only"
    echo "  5) Install for GitHub Copilot only"
    echo "  6) Uninstall all"
    echo "  0) Exit"
    echo ""
    read -p "Choose an option [1]: " choice
    choice=${choice:-1}

    case $choice in
        1)
            for tool in "${tools[@]}"; do
                install_$tool
                echo ""
            done
            ;;
        2) install_claude ;;
        3) install_cursor ;;
        4) install_windsurf ;;
        5) install_copilot ;;
        6) uninstall ;;
        0) exit 0 ;;
        *) echo -e "${RED}Invalid option${NC}"; exit 1 ;;
    esac
}

# Main
if [ "$1" == "--uninstall" ] || [ "$1" == "-u" ]; then
    uninstall
elif [ "$1" == "--claude" ]; then
    install_claude
elif [ "$1" == "--cursor" ]; then
    install_cursor
elif [ "$1" == "--windsurf" ]; then
    install_windsurf
elif [ "$1" == "--copilot" ]; then
    install_copilot
elif [ "$1" == "--all" ]; then
    tools=($(detect_tools))
    for tool in "${tools[@]}"; do
        install_$tool
        echo ""
    done
else
    show_menu
fi

echo ""
echo -e "${BLUE}Done! Run 'git pull && ./install.sh' to update.${NC}"
