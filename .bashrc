
# -- ENVIRONMENT VARIABLES --

# Set a more descriptive prompt
PS1='[\u \W$(__git_ps1 " (%s)")]\$ '


# -- LOCAL FUNCTIONS --

# Force gpg-agent to prompt password without waiting for the cache to clear
gpg-reload() {
  pkill scdaemon
  pkill gpg-agent
  gpg-connect-agent /bye >/dev/null 2>&1
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
  gpgconf --reload gpg-agent
}


# -- SOURCED SCRIPTS

# Include bash aliases
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
if [ -f ~/.bash_aliases_local ]; then
  source ~/.bash_aliases_local
fi

# Add Bash completion for macOS
[[ -f /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion


# Include git utilities
source ~/.git-completion.bash
source ~/.git-prompt.sh
