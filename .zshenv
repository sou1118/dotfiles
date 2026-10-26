export PATH="$HOME/.local/bin:$PATH"
[[ $OSTYPE == darwin* ]] && export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
