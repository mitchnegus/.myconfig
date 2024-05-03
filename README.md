# My Configuration

My preferred system configurations—dotfiles for bash, vim, git, etc.—all bundled together.


## Background

My configuration is tracked using the bare repository contained in the `.myconfig` directory.
This setup adapts the template provided by Nicola Paolucci in his [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).

Following the process described there, use the `config` alias to perform Git operations on the configuration files (without needing to run Git with the `--git-dir` and `--work-tree` options every time).
For example, to add and commit files, run

```bash
$ config add file.txt
$ config commit -m "commit message"
```

That `config` alias is defined in the `.bash_aliases` file using the command

```bash
$ alias config='$(which git) --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
```

By setting the working tree to be in the `$HOME` directory, the configuration files will be checked out into `$HOME` (where the system will go looking for them), rather than the default Git directory `.myconfig`.
Since the `$HOME` directory is likely to contain files that should not be tracked (e.g. everything that is not a configuration file), it is convenient to hide untracked files in Git status messages:

```bash
$ config config --local status.showUntrackedFiles no
```


## Installation


### Cloning and Checkout

To install these configuration files on your system, first clone the bare repo into the `.myconfig` directory.

```bash
$ git clone --bare <git_repo_source> $HOME/.myconfig
```

Since the `config` alias is defined in the `.bash_aliases` file (or potentially overwritten using a local `.bash_aliases` files), define the alias immediately after cloning.

```bash
$ alias config='$(which git) --git-dir=$HOME/.myconfig/ --work-tree=$HOME'
```

Checkout the files to the work tree in the `$HOME` directory, being cautious not to overwrite existing files.
Git will warn you before overwriting existing files.

```bash
$ config checkout
```

If conflicting files are present, either move them to a new location, or add them to the Git index (`config add <conflicting-file>`) before stashing them and comparing them to the commited versions that will be checked out from the repository.


### Configuring the Configurations

Once checked out, Git will consider every single file (including non-config files, directories, executables, etc.) in the users `$HOME` directory as untracked.
To avoid lengthy status reports when trying to commit/manage configuration files, configure the Git repository to ignore untracked files.

```bash
$ config config --local status.showUntrackedFiles no
```

Be aware that any new files will not be automatically shown by `config status` and will need to be added via `config add <new-file>`.
Likewise, running the `config add -A` command will attempt to add every file in `$HOME` to the index, including non-config files.
This is probably not the intended outcome.

An alternative approach could be to ignore all these files using either a `.gitignore` or `.git/info/exclude` and then force tracking, but I feel like using the configuration option is a bit more natural once you get the hang of it (and generally a lot less work than manually adding explicit ignores.


#### Submodules

This configuration package also contains a collection of submodules, including my Vim dotfiles and the Git source code.
These separate Git repositories are included in this repo for convenience—the Vim dotfiles do not need to be cloned separately, and utility scripts provided by Git can be relied on even in environments where those scripts are not otherwise available.

To initialize (and update) the submodule, run:

```bash
$ config submodule update --init --recursive
```

Most notably, this command will populate the `.vim` directory with my Vim configuration.
Be aware, however, that it will **not** install the associated plugins, and so the instructions in the Vim repo should be followed to do that.


#### Local Branches

It is expected that local machines will have different configurations.
As such, the configuration files in this public repo are intended only as a generally applicable basic configuration.
For local machines, it is recommended that you create a distinct branch with any local-specific configuration adjustments (e.g. by updating the configuration files here, or adding local add-ons such as a `.bash_aliases_local` file).
Since these local branches should probably not be pushed to remote systems, you can protect a local branch and prevent it from being pushed by setting the appropriate Git config option:

```bash
$ config config branch.<local_branch_name>.remote no_push
```

*Note: This shortcut only prevents branches from being pushed when a remote repository is not otherwise specified (e.g., via `config push` as opposed to `config push origin <branch_name>`).
