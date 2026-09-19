#
# -- BASH SETTINGS & VARIABLES --
#

# Append to history file (do not overwrite)
shopt -s histappend
# Use `**` for directory wildcard expansion
shopt -s globstar

# Control history settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=3000
HISTTIMEFORMAT="%F %T "


#
# -- ENVIRONMENT VARIABLES --
#

# Set options for commonly used commands
export LS_OPTIONS_='--color=auto'
export GREP_OPTIONS_='--color=auto'
# Use colors on BSD-based systems
export CLICOLOR=1
export LSCOLORS=cxfxcxdxCxegedabagacad
# Use colors on Linux-based systems
export LS_COLORS='di=32:ln=35:so=32:pi=33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
# Deactivate the default Python virtual environment prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Set parameters for a local default Python virtual environment
export DEFAULT_VENV="$HOME/.default-venv"

# Add local scripts to the path
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"


#
# -- SOURCED SCRIPTS --
#

scripts=(
  # Include Bash aliases
  "$HOME/.bash_aliases"
  "$HOME/.bash_aliases_local"
  # Include Bash prompt/color utilities
  "$HOME/.bash_colors"
  "$HOME/.bash_prompt"
  # Activate Bash completion (macOS)
  "/usr/local/etc/profile.d/bash_completion.sh"
)
for script in ${scripts[@]}; do
  [[ -f $script ]] && source $script
done


#
# -- LOCAL SCRIPTS --
#

# Include Git utilities (if not yet included)
git_src_repo="$HOME/.git-src"
git_util_dir="$git_src_repo/contrib/completion"
git_diff_highlight_dir=$git_src_repo/contrib/diff-highlight
declare -F __git_complete > /dev/null || source "$git_util_dir/git-completion.bash"
declare -F __git_ps1 > /dev/null || source "$git_util_dir/git-prompt.sh"
if [ -z $(which diff-highlight) ] && [ -f "$git_diff_highlight_dir/Makefile" ]; then
  echo "An executable for \`diff-highlight\` was not found in the PATH;" \
       "attempting to build it from the local Git source repository"
  make -C $git_diff_highlight_dir --no-print-directory > /dev/null 2>&1
  ln -s $git_diff_highlight_dir/diff-highlight $HOME/bin/diff-highlight
fi


#
# -- LOCAL FUNCTIONS --
#

cdl() { cd $1; ls; }
up() { cd $(printf '../%.0s' $(seq 1 ${1:-1})); }


# Remove conflicting aliases
[[ $(type -t config) == "alias" ]] && unalias config
# Set user-configuration paths
_myconfig_git_dir="$HOME/.myconfig"
_myconfig_work_tree="$HOME"

config() {
  local git=$(which git) || { echo "The Git executable was not found"; return 1; }
  "$git" --git-dir=$_myconfig_git_dir --work-tree=$_myconfig_work_tree "$@"
}

_config_completion() {
  local -x GIT_DIR="$_myconfig_git_dir"
  local -x GIT_WORKTREE="$_myconfig_work_tree"
  # Pass execution to the Git master completion wrapper
  __git_wrap__git_main "$@"
}

# Apply Git completion to the `config` function
complete -o bashdefault -o default -o nospace -F _config_completion config


build-default-venv() {
  if [[ ! -d "$DEFAULT_VENV" ]]; then
    python3 -m venv "$DEFAULT_VENV"
  fi
  local dependencies="pip rich"
  "$DEFAULT_VENV/bin/python" -m pip install --upgrade $dependencies
}


render-markdown() {
  local DEFAULT_VENV_PYTHON="${DEFAULT_VENV}/bin/python"
  if [[ -f "$DEFAULT_VENV_PYTHON" ]]; then
    "$DEFAULT_VENV_PYTHON" -m rich.markdown $@
  else
    echo "The default environment \`$DEFAULT_VENV\` does not seem to exist."
  fi
}


activate-nearest-env() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    local env=$(find "$dir" -maxdepth 2 -name "activate" -path "*/bin/activate" | head -n1)
    if [[ -n "$env" ]]; then
      source "$env" && return
    fi
    dir=$(dirname "$dir")
  done
  echo "No virtual environment found in any parent directory."
}


# Force gpg-agent to prompt password without waiting for the cache to clear
gpg-reload() {
  pkill scdaemon
  pkill gpg-agent
  gpg-connect-agent /bye >/dev/null 2>&1
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
  gpgconf --reload gpg-agent
}


pip() {
  command pip --require-virtualenv "$@"
  if [[ "$?" -ne 0 ]]; then
    echo "Did you mean to run \`pip install\` outside of a virtual environment?"
    echo "(if yes, bypass this message by using \`command pip install\` instead)"
  fi
}
