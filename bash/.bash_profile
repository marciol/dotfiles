# run bashrc if this is a login, interactive shell
if [ -f ~/.bashrc ]
then
  source ~/.bashrc
fi

source ~/.bashrc.local

# Set HOST for ZSH compatibility
export HOST=$HOSTNAME

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

