# Bash Aliases

# Use `config` command for Git tracking of config files
alias config='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'

# Change directory shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Abbreviate commonly used commands
alias la='ls -la'
alias lh='ls -lh'
alias back='cd -'

# Abbreviate commonly used grep options
alias grepr='grep -r'
alias grepyr='grep -r --include "*.py"'

# Shorten Jupyter notebook initialization
alias jnb='jupyter notebook'

# Miscellaneous (neat) tricks
alias flw='cd $(dirname $_.)'
alias please='sudo $(fc -ln -1)'

# Git aliases
alias gsta='git status'
alias gbra='git branch'
alias glog='git log'
alias gllum='git pull upstream main'
alias gllom='git pull origin main'
alias gshom='git push origin main'
alias gshoh='git push origin HEAD'
alias gshop='git push origin gh-pages'
alias greom='git rebase --onto main'
alias greoh='git rebase --onto HEAD'
alias gitadd='git add'
