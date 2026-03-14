# ============================================================================
# Zsh Aliases - Curated for Speed and Productivity
# ============================================================================
# This file is sourced by ~/.zshrc
# Add custom aliases to ~/.zshrc.local (not tracked by git)
#
# Organized by category for easy maintenance
# ============================================================================

# ----------------------------------------------------------------------------
# GIT (Most Used - 16 aliases)
# ----------------------------------------------------------------------------

# Status & Info
alias gst='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate'
alias glog='git log --oneline --decorate --graph'

# Add & Commit
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'

# Branch & Checkout
alias gco='git checkout'
alias gcb='git checkout -b'

# Push & Pull
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias gf='git fetch'

# Stash
alias gsta='git stash'
alias gstp='git stash pop'
alias grhh='git reset --hard HEAD'

# ----------------------------------------------------------------------------
# UBUNTU/APT (7 aliases)
# ----------------------------------------------------------------------------

alias apti='sudo apt install'
alias aptr='sudo apt remove'
alias apts='apt search'
alias aptu='sudo apt update'
alias aptug='sudo apt upgrade'
alias aptar='sudo apt autoremove'
alias agar='sudo apt autoremove'

# ----------------------------------------------------------------------------
# NAVIGATION (4 aliases)
# ----------------------------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ----------------------------------------------------------------------------
# FILE LISTING - eza (conditional)
# ----------------------------------------------------------------------------

if command -v eza &> /dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias l='eza --icons --group-directories-first'
  alias la='eza --icons --group-directories-first -a'
  alias ll='eza --icons --group-directories-first -l'
  alias lla='eza --icons --group-directories-first -la'
  alias lt='eza --icons --group-directories-first --tree'
  alias lta='eza --icons --group-directories-first --tree -a'
else
  alias ls='ls --color=auto --group-directories-first'
  alias la='ls -A --color=auto'
  alias ll='ls -l --color=auto'
  alias lla='ls -lA --color=auto'
fi

# ----------------------------------------------------------------------------
# CAT - bat (conditional)
# ----------------------------------------------------------------------------

if command -v bat &> /dev/null; then
  alias cat='bat --paging=never'
  alias catp='bat --paging=never --plain'
  alias catl='bat --paging=never --language'
fi

# ----------------------------------------------------------------------------
# SAFETY (4 aliases)
# ----------------------------------------------------------------------------

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'

# ----------------------------------------------------------------------------
# MODERN TOOLS (3 aliases)
# ----------------------------------------------------------------------------

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ----------------------------------------------------------------------------
# AI ASSISTANTS (custom)
# ----------------------------------------------------------------------------

alias k='kimi'
alias g='gemini'
alias c='claude'

# ----------------------------------------------------------------------------
# GOOGLE DRIVE (WSL specific - adjust paths to your setup)
# ----------------------------------------------------------------------------

alias mntgdu='sudo mount -t drvfs H: /mnt/h'
alias mntgds='sudo mount -t drvfs G: /mnt/g'

# Sync script location (change ~/Documents to your actual project location)
alias sync-gdrive='nohup ~/Documents/sync-to-gdrive.sh &>/dev/null &'

# ============================================================================
# TOTAL: ~50 aliases organized by category
# Add your custom aliases to ~/.zshrc.local (sourced after this file)
# ============================================================================
