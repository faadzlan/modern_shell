# Modern Shell Setup - Agent Guidelines

## Project Goal
Create a cross-platform, modern terminal experience replicating PowerShell 7's best features in Zsh. This configuration should be easily deployable across multiple Linux machines (Ubuntu, WSL, etc.).

## What This Project Delivers

| Feature | Implementation | Benefit |
|---------|----------------|---------|
| **Autosuggestions** | zsh-autosuggestions | Gray ghost text like PS7 |
| **Syntax Highlighting** | fast-syntax-highlighting | Real-time error detection |
| **Fuzzy History** | fzf + key bindings | Better than Ctrl+R |
| **Visual Tab Completion** | fzf-tab | Menu with previews |
| **Smart Navigation** | zoxide | Jump to frequent dirs |
| **Modern File Listing** | eza | Better than ls |
| **Syntax-Highlighted Cat** | bat | Better than cat |

## Project Structure

```
~/Documents/modern_shell/
├── AGENTS.md                    # This file
├── FLIGHT_LOG.org               # Running log of setup decisions
├── README.md                    # Quick start guide
├── documentation/
│   ├── ps7_psreadline_guide.org # PS7 features reference
│   └── zsh_modern_terminal_guide.md  # Implementation details
├── tools/
│   └── shell/
│       ├── zshrc                # Main configuration
│       └── install_zsh_modern.sh # Automated installer
└── configs/                     # Symlink-ready dotfiles
    └── zsh/
        └── .zshrc -> ../../tools/shell/zshrc
```

## Key Design Decisions

### Why Zsh + Zinit (not Oh My Zsh)?
- **Speed**: Zinit loads plugins ~4x faster than OMZ
- **Control**: Fine-grained plugin loading order
- **Compatibility**: 100% bash script compatibility (unlike Fish)

### Why These Plugins?

| Plugin | Replaces | Why Chosen |
|--------|----------|------------|
| powerlevel10k | Custom prompt | Fast, informative, customizable |
| zsh-autosuggestions | PS7 predictions | Matches ghost text behavior |
| fast-syntax-highlighting | PS7 highlighting | Faster than zsh-syntax-highlighting |
| fzf-tab | MenuComplete | Fuzzy search in completion menu |
| fzf | PS7 history search | Industry standard fuzzy finder |

## Cross-Machine Compatibility

### Supported Environments
- ✅ Ubuntu 22.04+
- ✅ WSL (Windows Subsystem for Linux)
- ✅ Debian-based distros
- ⚠️ Other distros (may need package manager adjustments)

### Machine-Specific Overrides

Place custom settings in `~/.zshrc.local` (auto-sourced by main config):
```zsh
# ~/.zshrc.local - Machine-specific settings
export EDITOR="nvim"  # Different editor on this machine
alias work-specific="..."  # Work-only aliases
```

### API Keys and Secrets

**Never commit API keys to git!** Use the local secrets pattern:

1. **Copy the template** (created for you):
   ```bash
   cp ~/Documents/modern_shell/zshrc.local.example ~/.zshrc.local
   ```

2. **Add your keys** to `~/.zshrc.local`:
   ```zsh
   export NANOBANANA_API_KEY="your_key_here"
   export GROQ_API_KEY="your_key_here"
   export CLAUDE_CODE_MAX_OUTPUT_TOKENS=8192
   ```

3. **Secure the file**:
   ```bash
   chmod 600 ~/.zshrc.local
   ```

4. **Verify it's ignored**:
   ```bash
   cat ~/Documents/modern_shell/.gitignore | grep "\.local"
   # Should show: *.local, .zshrc.local
   ```

The main `zshrc` automatically sources `~/.zshrc.local` at the end, so your keys are available in every shell session.

**Files**:
| File | Purpose | In Git? |
|------|---------|---------|
| `zshrc.local.example` | Template showing required variables | ✅ Yes |
| `~/.zshrc.local` | Your actual secrets | ❌ No |
| `.gitignore` | Prevents accidental commits of .local files | ✅ Yes |

### Shared History Strategy
- Zsh uses `~/.zsh_history` (separate from bash)
- Enable `SHARE_HISTORY` to sync between simultaneous sessions
- HISTSIZE=50000 for long-term command memory

## Dependencies

### Required
| Package | Purpose | Install |
|---------|---------|---------|
| zsh | Shell | `apt install zsh` |
| git | Plugin management | `apt install git` |
| curl | Downloads | `apt install curl` |

### Recommended
| Package | Purpose | Fallback |
|---------|---------|----------|
| fzf | Fuzzy finder | apt |
| eza | Modern ls | GitHub release |
| bat | Syntax cat | apt (as batcat) |
| zoxide | Smart cd | GitHub install script |
| fd | Fast find | apt (as fdfind) |

## Installation Methods

### Method 1: Automated (Recommended)
```bash
cd ~/Documents/modern_shell/tools/shell
./install_zsh_modern.sh
```

### Method 2: Manual Symlink
```bash
# For dotfiles management with git
ln -sf ~/Documents/modern_shell/tools/shell/zshrc ~/.zshrc
```

### Method 3: Copy
```bash
cp ~/Documents/modern_shell/tools/shell/zshrc ~/.zshrc
```

## Notes for Agents

### When Modifying Configurations
1. **Test in isolated session**: `zsh -f` then source the modified file
2. **Check startup time**: `time zsh -i -c exit` should be < 1000ms (see note below)
3. **Verify key bindings**: `bindkey` lists all current bindings
4. **Validate syntax**: `zsh -n ~/.zshrc` checks for syntax errors

**Note on Startup Time**: With the full plugin set (syntax highlighting, autosuggestions, fzf-tab, completions), expect ~800-900ms startup time. This is competitive with PowerShell 7 (~500-1000ms). To reach <200ms, you'd need to remove features or use zsh-defer for lazy loading.

### Adding New Plugins
Use Zinit syntax in `tools/shell/zshrc`:
```zsh
# Standard plugin
zinit light owner/repo

# With ice modifiers (load conditions, wait, etc.)
zinit ice wait"0" lucid
zinit light owner/repo

# Snippet (single file)
zinit snippet OMZ::plugins/git/git.plugin.zsh
```

### Platform-Specific Conditionals
```zsh
# WSL-specific
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    # WSL-specific settings
fi

# Check command availability
if command -v eza &> /dev/null; then
    alias ls='eza ...'
fi
```

### WSL-Specific Features

The zshrc includes automatic setup for WSL environments:

**Drive Auto-Mounting** (on shell startup):
```zsh
mountpoint -q /mnt/h 2>/dev/null || sudo mount -t drvfs H: /mnt/h 2>/dev/null
mountpoint -q /mnt/g 2>/dev/null || sudo mount -t drvfs G: /mnt/g 2>/dev/null
```

**SSH Keychain** (caches SSH key password):
```zsh
if command -v keychain &> /dev/null; then
  eval $(keychain --eval --quiet ~/.ssh/id_ed25519 2>/dev/null)
fi
```

**WSL Aliases**:
| Alias | Purpose |
|-------|---------|
| `mntgdu` | Mount H: drive (Google Drive) |
| `mntgds` | Mount G: drive (Google Drive Shared) |
| `winhome` | cd to Windows user home |

**Note**: Drive mounting requires `sudo` without password or manual password entry. To enable passwordless mounting:
```bash
sudo visudo
# Add: yourusername ALL=(ALL) NOPASSWD: /bin/mount
```

### Color Scheme Philosophy
- Use 256-color palette for broad compatibility
- Match PS7's subtle gray autosuggestions (fg=240)
- Prefer Catppuccin Mocha theme (similar to modern dark themes)

## References
- Zinit: https://zdharma-continuum.github.io/zinit/wiki/
- Powerlevel10k: https://github.com/romkatv/powerlevel10k
- fzf: https://github.com/junegunn/fzf
- zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions
- fast-syntax-highlighting: https://github.com/zdharma-continuum/fast-syntax-highlighting

## Troubleshooting Common Issues

### Issue: Slow Startup Time (>1000ms)
**Check**: Run `time zsh -i -c exit`
**Profile**: Use `zsh -c 'zmodload zsh/zprof; source ~/.zshrc; zprof'` to find slow functions

**Common causes**:
1. **p10k instant prompt not at top**: Must be first lines of zshrc, before any output
2. **compinit not cached**: Should use `compinit -C` for fast cached loading
3. **External processes in zshrc**: WSL `cmd.exe`, `tr`, `grep` in PATH manipulation
4. **Plugin bloat**: Each plugin adds 50-150ms

**Fix checklist**:
```bash
# 1. Check instant prompt location (should be line ~7)
head -15 ~/.zshrc | grep -A2 "p10k-instant-prompt"

# 2. Check compinit caching
grep "compinit -C" ~/.zshrc || echo "compinit not cached!"

# 3. Profile specific section
head -100 ~/.zshrc > /tmp/test.zsh
time zsh /tmp/test.zsh
```

**Realistic expectations**:
| Configuration | Expected Time |
|---------------|---------------|
| Minimal (no plugins) | ~50-100ms |
| Core plugins only | ~300-500ms |
| Full featured (current) | ~800-1000ms |
| With lazy loading (zsh-defer) | ~400-600ms |

### Issue: "jq binary not found"
**Error**: `❌ ERROR: jq binary not found`
**Cause**: Zinit requires jq for some pack operations
**Fix**:
```bash
sudo apt install -y jq
```

### Issue: "patch-dl annex not installed"
**Error**: `ERROR: the requested profile 'binary+keys' requires the 'patch-dl' annex`
**Cause**: Using zinit's `pack` system requires additional annexes
**Fix**: Don't use the pack system. Replace in zshrc:
```zsh
# ❌ Problematic (requires annexes)
zinit pack"binary+keys" for fzf

# ✅ Reliable alternative
zinit from"gh-r" as"program" for junegunn/fzf
source <(fzf --zsh 2>/dev/null || echo "")
```

### Issue: fzf key bindings not working
**Check**: Press `Ctrl+T` - should open file finder
**Fix**: Add manual key bindings to zshrc:
```zsh
# For fzf >= 0.48
source <(fzf --zsh 2>/dev/null || echo "")

# For older fzf versions
source /usr/share/doc/fzf/examples/key-bindings.zsh 2>/dev/null || true
source /usr/share/doc/fzf/examples/completion.zsh 2>/dev/null || true
```

## Recommended zshrc Structure

Based on installation experience, here's the reliable loading order:

```zsh
# 0. INSTANT PROMPT (MUST BE FIRST - before any output)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 1. Zinit setup
source "${ZINIT_HOME}/zinit.zsh"

# 2. Prompt (load first for instant prompt)
zinit ice depth=1; zinit light romkatv/powerlevel10k

# 3. Core plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# 4. FZF (reliable method - no pack system)
zinit from"gh-r" as"program" for junegunn/fzf

# 5. FZF key bindings (cached path check for speed)
if [[ -f ~/.local/share/zinit/plugins/junegunn---fzf/shell/key-bindings.zsh ]]; then
  source ~/.local/share/zinit/plugins/junegunn---fzf/shell/key-bindings.zsh
else
  source <(fzf --zsh 2>/dev/null || echo "")
fi

# 6. FZF-tab (for visual completions)
zinit light Aloxaf/fzf-tab

# 7. Additional completions
zinit light zsh-users/zsh-completions

# 8. COMPLETION SYSTEM (cached for speed)
autoload -Uz compinit
if [[ -f ~/.cache/zcompdump ]]; then
  compinit -C -d ~/.cache/zcompdump  # Use cache (fast)
else
  compinit -d ~/.cache/zcompdump     # First run only
fi
```

## Profiling Startup Time

To diagnose slow startup:

```bash
# Quick timing
time zsh -i -c exit

# Detailed function profiling
zsh -c '
  zmodload zsh/zprof
  source ~/.zshrc
  zprof
'

# Check for external processes
zsh -xv -i -c exit 2>&1 | grep -E "(subshell|\$\()" | head -20

# Bisection testing (find slow section)
for n in 50 100 150 200 250 300; do
  echo -n "First $n lines: "
  time (zsh -c "$(head -$n ~/.zshrc); exit" 2>&1)
done
```

## Notes on Zinit Pack System

The `zinit pack` system provides convenience profiles for popular tools but:
- Requires additional annexes (patch-dl, bin-gem-node)
- Can fail silently if annexes missing
- Harder to debug than direct loading

**Recommendation**: Use direct `from"gh-r" as"program"` loading for GitHub release binaries. It's explicit, reliable, and easier to troubleshoot.
