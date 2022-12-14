# run bashrc if this is a login, interactive shell
if [ -f ~/.bashrc ]
then
  source ~/.bashrc
fi

source ~/.bashrc.local

# Set HOST for ZSH compatibility
export HOST=$HOSTNAME
export BASH_SILENCE_DEPRECATION_WARNING=1

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
