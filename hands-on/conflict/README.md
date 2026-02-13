# Conflict

When merging branches, you may have to resolve a conflict.  This directory
contains scripts to help you set up a repository, do a merge and resolve the
resulting conflict.


## What is it?

1. `create_repo.sh`: Bash script to create an initial repository.
1. `src`: directory with the initial source file for the project.
1. `src_01`, `src_02`, `src_o3`, `src_04`: evolving versions of the source
   file.


## How to use it?

First create the repository.  Note the directory containing the repository
should not be in an existing git repository.

```bash
$ ./create_repo.sh /tmp/my_repo
```

Chance to the repository's directory.

```bash
$ cd /tmp/my_repo
```

The script `create_repo.sh` has created two branches, the `main` branch, and
a feature branch `feature/improve_cli`.

You can list the branches using the following command.

```bash
$ git branch
```

The branch marked with a `*` is the active branch.

Since you want to merge the changes made in the feature branch
`feature/improve_cli`, you can execute the merge command.

```bash
$ git merge feature/improve_cli
```

You will see that the command results in a conflict.  Edit the file so that
it reflects the changes you acgtually want to make.  When that is done,
stage the file and commit.  This resolves the conflict.

```bash
$ git add src/hello.py
$ git commit -m 'Resolve conflict'
```
