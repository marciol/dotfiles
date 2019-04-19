# run bashrc if this is a login, interactive shell
if [ "$0" = "-bash" ] && echo "$-" | grep -q "i"
then
  source ~/.bashrc
fi

# Set HOST for ZSH compatibility
export HOST=$HOSTNAME
