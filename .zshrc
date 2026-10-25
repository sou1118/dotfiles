typeset -U path fpath

# Homebrew（mise が /opt/homebrew に入れる）
path=(/opt/homebrew/bin /opt/homebrew/sbin $HOME/.local/bin $path)
fpath+=(/opt/homebrew/share/zsh/site-functions)

autoload -U compinit && compinit

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

eval "$(mise activate zsh)"

if [[ $TERM != "dumb" ]] && command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

alias cat=bat
alias ls=lsd
