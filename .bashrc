
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

activate-nearest-env() {
  env=$(find / -exec bash -c '[[ $PWD/ != "${1%/}/"* ]]' bash {} \; -prune -name *env -print | tail -n1)
  source $env/bin/activate
}

pip() {
  if [ "$1" == "install" ] && [ -z $VIRTUAL_ENV ]; then
    echo "Did you mean to run \`pip install\` outside of a virtual environment?"
    echo "(if yes, bypass this message by using \`command pip install\` instead)"
  else
    command pip "$@"
  fi
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

# Include Git utilities (if not yet included)
git_src_repo="$HOME/.git-src"
git_util_dir="$git_src_repo/contrib/completion"
declare -F __git_complete > /dev/null || source "$git_util_dir/git-completion.bash"
declare -F __git_ps1 > /dev/null || source "$git_util_dir/git-prompt.sh"
