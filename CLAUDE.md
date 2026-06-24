# Agent Instructions: Claude

## Overview
This file contains Claude-specific guidance for working on the Modern Shell Setup project.

## Primary Reference
See [AGENTS.md](AGENTS.md) for general project structure, conventions, and troubleshooting.

## Claude-Specific Context

### Local Invocation
The `c` alias invokes the Claude CLI in this shell configuration:
```zsh
alias c='claude'
```

### API Key Location
If using Claude Code or the Claude CLI, API keys should be set in `~/.zshrc.local` (not committed to git):
```zsh
export ANTHROPIC_API_KEY="your_key_here"
```

### Project Preferences
- Follow the zshrc structure and loading order defined in AGENTS.md
- Maintain the ~800-1000ms startup time target for the full plugin set
- When adding new plugins, prefer `zinit light` or `zinit from"gh-r" as"program"` over the pack system
- Test changes with `zsh -n ~/.zshrc` for syntax validation
