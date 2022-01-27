# Set a more descriptive prompt
PS1='[\u \W$(__git_ps1 " (%s)")]\$ '

# Include custom scripts in path
export PATH="$HOME/bin:$PATH"

# Set environment variables
export VIM="$HOME/.vim"

# Force gpg-agent to prompt password without waiting for the cache to clear
gpg-reload() {
  pkill scdaemon
  pkill gpg-agent
  gpg-connect-agent /bye >/dev/null 2>&1
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
  gpgconf --reload gpg-agent
}

# Include bash aliases
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
if [ -f ~/.bash_aliases_local ]; then
  source ~/.bash_aliases_local
fi

# Include git utilities
source ~/.git-completion.bash
source ~/.git-prompt.sh

