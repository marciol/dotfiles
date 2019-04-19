# Dotfiles

A repository with my personal configuration files. Managed using GNU
[stow][stow].

## How to use

Clone this repository (including submodules) in `~/.dotfiles` directory, e.g.:

    $ git clone --recursive https://github.com/thiagokokada/dotfiles ~/.dotfiles

Use `stow` to manage symlinks, e.g.:

    $ cd ~/.dotfiles
    $ stow .

[stow]: https://www.gnu.org/software/stow/
