# Cherry-pick

It can sometimes be useful to bring in one or more commits done in a branch
into another branch without merging.  This can easily be done using `git
cherry-pick`.


## What is it?

1. `create_repo.sh`: Bash script to create an initial repository.
1. `src`: directory with the initial source file for the project.
1. `project_README.md`: original README file for the repository.
1. `project_README_corrected.md`: corrected README file for the repository.
1. `src_01`, `src_02`: evolving versions of the source file.


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

When you check the log messages for the branch `feature/improve_cli`, you
notice that a typo has been fixed.

You can check what has been modified in that commit using `git show` with
the appropriate commit ID.

```bash
$ git show 6ece05f
```

As you can see, a typo in the README file was fixed.

It would be a good idea to have that same fix in the `main` branch as
well.  However, you do not want to merge the branch `feature/improve_cli`
into `main` as yet.

You can bring in a single commit though.  First, switch to the `main`
branch.

```bash
$ git swtich main
```

Next, cherry-pick the commit that fixed the typo.

```bash
$ git cherry-pick 6ece05f
```

When you check the log, you will see a new commit that fixes the typo
in the `main` branch.

```bash
$ git log
```
