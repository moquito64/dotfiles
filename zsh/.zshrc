# ~/.zshrc

# History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Options
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e

# Completion
autoload -Uz compinit
: "${XDG_CACHE_HOME:=$HOME/.cache}"
mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Plugins
if [[ "$(uname)" == "Darwin" ]]; then
  if command -v brew >/dev/null 2>&1; then
    BREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi
else
  [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Python alias (mac only)
if [[ "$(uname)" == "Darwin" ]]; then
  alias python=/usr/bin/python3
fi

# Global aliases
[ -f ~/.config/zsh/aliases.zsh ] && source ~/.config/zsh/aliases.zsh

# Local machine-specific overrides
[ -f ~/.zsh_local ] && source ~/.zsh_local

# Tool inits
if command -v fzf >/dev/null 2>&1 && fzf --zsh >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi
command -v zoxide   >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
