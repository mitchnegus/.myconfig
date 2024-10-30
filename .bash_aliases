# Bash Aliases

# Use `config` command for Git tracking of config files
alias config='$(which git) --git-dir=$HOME/.myconfig/ --work-tree=$HOME'

# Change directory shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Sort the output of printenv
if printenv -0 &> /dev/null; then
  # Use non-standard extensions in GNU coreutils version of `printenv`
  # (https://stackoverflow.com/a/60756021)
  alias printenv='printenv -0 | sort -z | tr "\0" "\n"'
else
  alias printenv='printenv | grep -v "COLOR*" | sort'
fi

# Abbreviate commonly used commands
alias ls='ls $LS_OPTIONS_'
alias la='ls -la'
alias lh='ls -lh'
alias grep='grep $GREP_OPTIONS_'
alias back='cd -'
alias bashrcload='source $HOME/.bashrc'
alias rmd='render-markdown'

# Abbreviate commonly used grep options
alias grepr='grep -r'
alias grepyr='grep -r --include "*.py"'

# Shorten Jupyter notebook initialization
alias jnb='jupyter notebook'

# Shortcut for activating the "nearest" Python virtual environment
alias activenv='activate-nearest-env'

# Miscellaneous (neat) tricks
alias flw='cd $(dirname $_.)'
alias please='sudo $(fc -ln -1)'
alias hardclear='printf "\33c\e[3J"'

# Git aliases
alias gshow='git show'
alias gsta='git status'
alias gbra='git branch'
alias glog='git log'
alias glogg='git logg'
alias gllum='git pull upstream main'
alias gllom='git pull origin main'
alias gshom='git push origin main'
alias gshoh='git push origin HEAD'
alias gshop='git push origin gh-pages'
alias grebo='git rebase --onto'
alias grebom='git rebase --onto main'
alias greboh='git rebase --onto HEAD'
alias grebcon='git rebase --continue'
alias gremp='git remote prune'
alias grempo='git remote prune origin'
alias gitadd='git add'
alias qgit='git'
