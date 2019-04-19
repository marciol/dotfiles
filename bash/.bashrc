# Rust Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# PHP
export PATH=$PATH:$HOME/.composer/vendor/bin

# Dart
export PATH="/usr/local/opt/dart/libexec:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Elixir
export PATH="$PATH":"$HOME/bin/elixir-ls"
export CORTEX_ENABLED=true
export ERL_AFLAGS="-kernel shell_history enabled"

# Go
GOPATH=$HOME/go
export GOPATH
PATH=$GOPATH/bin:$PATH

# Ruby
eval "$(rbenv init -)"
alias be="bundle exec"

# VSCode (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Emacs
export GTAGSLABEL=pygments
alias ec="emacsclient -c"

# Neovim default editor
export EDITOR=nvim

# VIS
export VIS_PATH=$HOME/vis

# ASDF
source /usr/local/opt/asdf/asdf.sh

# FZF
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_COMMAND='fd --type f'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fzf_then_open_in_editor() {
  local file=$(fzf-tmux)
  # Open the file if it exists
  if [ -n "$file" ]; then
    # Use the default editor if it's defined, otherwise Vim
    ${EDITOR:-nvim} "$file"
  fi
}
bind -x '"\C-t": fzf_then_open_in_editor'

PATH=$HOME/bin:$PATH
PATH=$PATH:/usr/local/sbin
export PATH

# Bash
BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  source `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

if [ -f `brew --prefix`/etc/bash_completion.d/git-prompt.sh ]; then
  source `brew --prefix`/etc/bash_completion.d/git-prompt.sh
  GIT_PS1_SHOWDIRTYSTATE=true
fi

set -o vi
bind '"jj":vi-movement-mode'

if [[ -z "$SSH_CLIENT" ]]; then
    # local connection, change prompt
    export PS1="\w\$(__git_ps1) \\$ "
else
    # ssh connection, print hostname and os version
    echo "Welcome to $(scutil --get ComputerName) ($(sw_vers -productVersion))"
fi

# GITHUB
export GITHUB_TOKEN=35662a410ae5b7804b295e12c2b169c00ac9bfe8

