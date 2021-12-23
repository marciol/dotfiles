# Dotfiles

A repository with my personal configuration files. Managed using GNU
[stow][stow].

## How to use

1. [Generate a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

2. Ensure that the key is on ssh-agent:
    ```shell
    eval "$(ssh-agent -s)"
    ssh-add -K ~/.ssh/key_rsa

    ```
3. [Add a new SSH Key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)


    ```shell
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/marciol/dotfiles/HEAD/install.sh)"
    ```

[stow]: https://www.gnu.org/software/stow/
