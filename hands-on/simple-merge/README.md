# Merging branches

When merging branches, the history of these branches gets intertwined.  This
can lead to a confusing log, making it hard to interprete the project's
history.

You can examine the impact on the history of a simple merge, or a merge
with `--squash`.


## What is it?

1. `create_repo.sh`: Bash script to create an initial repository.
1. `src`: directory with the initial source file for the project.
1. `src_01_hello`, `src_02_hello`, `src_o3_hello`: evolving versions of the
   source files in the `feature/hello_cli` branch.
1. `src_01_bye`, `src_02_bye`, `src_o3_bye`: evolving versions of the
   source files in the `feature/bye_cli` branch.


## How to use it?

First create the repository.  Note the directory containing the repository
should not be in an existing git repository.

```bash
$ ./create_repo.sh /tmp/my_repo
```

**Note**: this will take longer than you might expect.  The script has sleep
statements to ensure the commit times differ significantly.

Chance to the repository's directory.

```bash
$ cd /tmp/my_repo
```

The script `create_repo.sh` has created three branches, the `main`,
the `feature/hello_cli` and `feature/bye_cli` branches.
a feature branch `feature/improve_cli`.

You can list the branches using the following command.

```bash
$ git branch
```

The branch marked with a `*` is the active branch.

Since you want to merge the changes made in the feature branch
`feature/hello_cli`, you can execute the merge command.

```bash
$ git merge feature/hello_cli
```

You want to do the same with the other feature branch.

```bash
$ git merge feature/bye_cli
```

When you examine the history, you will see that it look rather mangled.

```bash
$ git log --oneline
```

If you like, you can compare this to what happens if you use the `--squash`
option when you merge the branches.  First, hard reset the `main` branch to
undo the merges.

Next, merge the feature branches using `--squash`.

```bash
$ git merge --squash feature/hello_cli
$ git commit -m 'Improve hello CLI'
$ git merge --squash feature/bye_cli
$ git commit -m 'Improve bye CLI'
```

Now you will see only three commits, and a very clean hisotry.
