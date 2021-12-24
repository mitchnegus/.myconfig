# Bash Aliases

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
alias gllum='git pull upstream master'
alias gshom='git push origin master'
alias gllom='git pull origin master'
alias gshop='git push origin gh-pages'
alias gshoh='git push origin HEAD'
alias gitadd='git add'
