# My Configuration

My preferred system configurations—dotfiles for bash, vim, git, etc.—all bundled together.


## Background

My configuration is tracked using the bare repository contained in the `.myconfig` directory.
This setup follows the template provided by Nicola Paolucci in his [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).

Following the process described there, use the `config` alias to perform Git operations on the configuration files.
For example, to add and commit files, run

```
config add file.txt
config commit -m "commit message"
```

The alias is defined in the `.bash_aliases` file using the command

```
alias config='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
```

By setting the working tree to be in the `$HOME` directory, the configuration files will be checked out into `$HOME` (where the system will go looking for them), rather than the default Git directory `.myconfig`.
Since the `$HOME` directory is likely to contain files that should not be tracked (e.g. everything that is not a configuration file), it is convenient to hide untracked files in Git status messages:

```
config config --local status.showUntrackedFiles no
```

(An alternative would be to ignore all these files using either a `.gitignore` or `.git/info/exclude` and then force tracking, but I feel like this option is a bit more natural.)

