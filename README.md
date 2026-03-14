# Modern Shell Setup

A cross-platform Zsh configuration that replicates PowerShell 7's best features:
- **Predictive suggestions** (gray ghost text)
- **Visual tab completion** with fuzzy search
- **Enhanced history search** (Ctrl+R)
- **Real-time syntax highlighting**
- **Smart directory navigation**
- **Colorized, informative file listings**

## Quick Start

```bash
# 1. Clone/copy this project to ~/Documents/modern_shell
cd ~/Documents/modern_shell

# 2. Run the installer
./tools/shell/install_zsh_modern.sh

# 3. Start Zsh
zsh

# 4. (Optional) Set as default shell
chsh -s $(which zsh)
```

## What You Get

### 1. Autosuggestions (Ghost Text)
Type a command, see gray suggestion from your history:
```bash
$ git com[m -m "previous message"]  # gray = suggestion
```
- `→` (Right Arrow): Accept entire suggestion
- `Ctrl+F`: Accept one word at a time

### 2. Visual Tab Completion
Press `Tab` for a fuzzy-searchable menu:
```
> git che[TAB]
▶ checkout       cherry-pick
  cherry         check-attr
```
- Type to filter, `↑/↓` to navigate, `Enter` to select
- Preview window shows file contents or git diffs

### 3. Enhanced History Search
`Ctrl+R` for fuzzy history:
```
> docker
  483  docker ps -a
  290  docker-compose up -d
  125  docker build -t myapp .
```

### 4. Smart Directory Navigation
`z` learns your habits:
```bash
$ z doc        # cd ~/Documents
$ z pro        # cd ~/Projects
$ zi           # Interactive directory selection
```

### 5. Modern File Listing
`ls` is now `eza` with icons and git status:
```
$ ls
drwxr-xr-x  - user 12 Mar 20:30  src/
drwxr-xr-x  - user 12 Mar 20:31  tests/
.rw-r--r--  2k user 12 Mar 20:25  Cargo.toml   # M = modified
```

## Key Bindings

| Key | Action |
|-----|--------|
| `→` | Accept entire autosuggestion |
| `Ctrl+F` | Accept one word of suggestion |
| `Ctrl+R` | Fuzzy history search |
| `Ctrl+T` | Fuzzy file finder |
| `Alt+C` | Fuzzy cd to directory |
| `Tab` | Visual completion menu |
| `Ctrl+←/→` | Navigate by word |
| `Home/End` | Start/end of line |

## Included Tools

| Tool | Purpose | Why |
|------|---------|-----|
| **zsh** | Shell | Better than bash for interactive use |
| **zinit** | Plugin manager | Fast, modern, turbo loading |
| **powerlevel10k** | Prompt | Fast, informative, customizable |
| **fzf** | Fuzzy finder | Industry standard |
| **fzf-tab** | Completion | Visual, fuzzy menu |
| **zsh-autosuggestions** | Ghost text | Like PS7 predictions |
| **fast-syntax-highlighting** | Highlighting | Real-time error detection |
| **eza** | File listing | Better than `ls` |
| **bat** | File viewer | Syntax-highlighted `cat` |
| **zoxide** | Directory jumping | Smarter than `cd` |
| **fd** | File finder | Faster than `find` |

## Customization

### Machine-Specific Settings
Create `~/.zshrc.local` for settings that vary by machine:
```bash
# ~/.zshrc.local
export EDITOR="nvim"
alias work-vpn="sudo openconnect ..."
```

### Changing the Theme
Run `p10k configure` to customize the prompt:
```bash
p10k configure
```

### Modifying FZF Colors
Edit `FZF_DEFAULT_OPTS` in `~/.zshrc`:
```bash
export FZF_DEFAULT_OPTS="--color=bg+:#363a4f,..."
```

## Project Structure

```
~/Documents/modern_shell/
├── AGENTS.md              # Project context for AI agents
├── FLIGHT_LOG.org         # Decisions, lessons learned
├── README.md              # This file
├── documentation/
│   ├── ps7_psreadline_guide.org    # PS7 feature reference
│   └── zsh_modern_terminal_guide.md # Detailed Zsh guide
└── tools/shell/
    ├── zshrc              # Main configuration
    └── install_zsh_modern.sh  # Automated installer
```

## Updating

```bash
# Pull latest changes
cd ~/Documents/modern_shell
git pull

# Re-run installer to update dependencies
./tools/shell/install_zsh_modern.sh

# Or just reload config
source ~/.zshrc
```

## Troubleshooting

### Slow Startup
```bash
# Check startup time
time zsh -i -c exit
# Should be < 200ms
```

### Missing Icons
Install a Nerd Font (e.g., "MesloLGS NF") in your terminal.

### Autosuggestions Not Showing
```bash
# Check if plugin loaded
ls ~/.local/share/zinit/plugins/zsh-users---zsh-autosuggestions/

# Clear cache and restart
rm ~/.cache/zcompdump*
exec zsh
```

## License

MIT - Use freely across your machines.
