#!/bin/bash
set -u

echo "Installing xcode tools"
xcode-select --install

# Homebrew
echo "Installing homebrew and stow"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install stow git

# Dotfiles
echo "Installing the dotfiles"
git clone git@github.com:marciol/dotfiles.git $HOME/.dotfiles

pushd $HOME/.dotfiles

# Stow
echo "Initializing stow"
stow clojure
stow ctags
stow git
stow kitty
stow local
stow nvim
stow ruby
stow ssh
stow tags
stow brew

popd

# Brewbundle
echo "Brew bundle ..."
brew bundle

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

# Rust
echo "Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh --profile default

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
asdf install

# Clojure
echo "Installing clojure"
brew install clojure/tools/clojure
brew install clojure-lsp/brew/clojure-lsp-native

# Kitty
echo "Installing kitty"
brew install --cask kitty
