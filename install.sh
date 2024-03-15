#!/bin/bash
set -u

if [ "$(uname -s)" == "Darwin" ]; then
  echo "Installing xcode tools"
  xcode-select --install
fi

# Homebrew
echo "Installing homebrew and stow"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ "$(uname -s)" == "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/home/linuxbrew/bin/brew shellenv)" 
fi
brew install stow git

# Dotfiles
echo "Installing the dotfiles"
[ ! -d $HOME/.dotfiles ] && git clone git@github.com:marciol/dotfiles.git $HOME/.dotfiles

pushd $HOME/.dotfiles

# Stow
echo "Initializing stow"
stow bash
stow asdf
stow clojure
stow ctags
stow git
stow kitty
stow local
stow nvim
stow ruby
stow ssh
stow brew
stow sublime

popd

# Bash
echo "source $HOME/.bashrc.local" > ~/.bashrc

# Git
echo "Installing git"
git config --global core.excludesfile ~/.gitignore_global

# Direnv
echo "Installing direnv"
curl -sfL https://direnv.net/install.sh | bash

# Fzf
echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

# Plug
echo "Installing plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Rust
echo "Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Brewbundle
echo "Brew bundle ..."
brew bundle

# Asdf
echo "Installing asdf"
[ ! -d $HOME/.asdf ] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
source $HOME/.asdf/asdf.sh
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add java https://github.com/halcyon/asdf-java.git
asdf plugin-add lein https://github.com/miorimmax/asdf-lein.git
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add rebar https://github.com/Stratus3D/asdf-rebar.git
asdf plugin-add lfe https://github.com/vic/asdf-lfe.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add clojerl https://github.com/clojerl/asdf-clojerl.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add terragrunt https://github.com/lotia/asdf-terragrunt
asdf plugin-add https://github.com/MetricMike/asdf-awscli.git
asdf install

# Neovim setup
echo "Installing NeoVim Plug"
nvim +PlugInstall +qall
