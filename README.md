# My Configuration

My preferred system configurations—dotfiles for bash, vim, git, etc.—all bundled together.


## Background

My configuration is tracked using the bare repository contained in the `.myconfig` directory.
This setup follows the template provided by Nicola Paolucci in his [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).

Following the process described there, use the `config` alias to perform Git operations on the configuration files.
For example, to add and commit files, run

```
$ config add file.txt
$ config commit -m "commit message"
```

The alias is defined in the `.bash_aliases` file using the command

```
alias config='$(which git) --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
```

By setting the working tree to be in the `$HOME` directory, the configuration files will be checked out into `$HOME` (where the system will go looking for them), rather than the default Git directory `.myconfig`.
Since the `$HOME` directory is likely to contain files that should not be tracked (e.g. everything that is not a configuration file), it is convenient to hide untracked files in Git status messages:

```
$ config config --local status.showUntrackedFiles no
```

(An alternative would be to ignore all these files using either a `.gitignore` or `.git/info/exclude` and then force tracking, but I feel like this option is a bit more natural.)


## Installation

To install these configuration files on your system, first clone the bare repo into the `.myconfig` directory.

```
$ git clone --bare <git_repo_source> $HOME/.myconfig
```

Since the `config` alias is defined in the `.bash_aliases` file (or potentially overwritten using a local `.bash_aliases` files), define the alias immediately after cloning.

```
$ alias config='<path_to_git_app> --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
```

Checkout the files to the work tree in the `$HOME` directory, being cautious not to overwrite existing files.
Git will warn you before overwriting existing files.

```
$ config checkout
```

Run the command for hiding untracked files to avoid lengthy Git status reports for the configuration files (which would otherwise include all non-config files in the `$HOME` directory):

```
$ config config --local status.showUntrackedFiles no
```


### Submodules

This configuration package also contains a submodule including my Vim dotfiles.
These are stored in a separate Git repository, and are included in this repo for convenience.
To initialize (and update) the submodule, run:

```
config submodule update --init --recursive
```

This command will add the `.vim` directory and Vim configuration to the `$HOME` directory.
Note that it will **not** install the associated plugins, and so the instructions in the Vim repo should be followed to do that.


## Local Branches

It is expected that local machines will have different configurations.
As such, the configuration files in this public repo are intended only as a generally applicable basic configuration.
For local machines, it is recommended that you create a distinct branch with any local-specific configuration adjustments (e.g. by updating the configuration files here, or adding local add-ons such as a `.bash_aliases_local` file).
Since these local branches should probably not be pushed to remote systems, you can protect a local branch and prevent it from being pushed by setting the appropriate Git config option:

```
config config branch.<local_branch_name>.remote no_push
```

*Note: This shortcut only prevents branches from being pushed when a remote repository is not otherwise specified (e.g., via `config push` as opposed to `config push origin <branch_name>`).
