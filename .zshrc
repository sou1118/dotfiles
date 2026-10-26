typeset -U path fpath

path=($HOME/.local/bin $path)

if [[ $OSTYPE == darwin* ]]; then
  # Homebrew（mise が /opt/homebrew に入れる）
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
  fpath+=(/opt/homebrew/share/zsh/site-functions)
fi

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

if [[ $OSTYPE == linux* ]]; then
  export LANG=en_US

  # ローカルセッションのみ 1Password の SSH Agent を使う（SSH 時は転送された agent を維持）
  if [[ -z "$SSH_CONNECTION" && -S "$HOME/.1password/agent.sock" ]]; then
    export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
  fi

  alias get_esprs='. $HOME/export-esp.sh'
  alias get_idf='. $HOME/esp/esp-idf/export.sh'
fi

command -v rg >/dev/null && alias grep=rg
command -v fzf >/dev/null && source <(fzf --zsh)
