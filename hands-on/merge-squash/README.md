# Merge-squash

When merging a feature branch, you may not want to keep the entre history,
i.e., all separate commits in the repository.  There are two scenarios to
accomplish that.

* git merge --squash
* git rebase -i


## What is it?

1. `create_repo.sh`: Bash script to create an initial repository.
1. `src`: directory with the initial source file for the project.
1. `work_in_branch.sh`: Bash script to do "work" on the source file, creating a
   commit in the repository's current branch after each step.
1. `src_01`, `src_02`, `src_o3`: evolving versions of the source file.


## How to use it?

### Scenario 1: merge-squash

First create the initial repository.  Note the directory containing the
repository should not be in an existing git repository.

```bash
$_1 ./create_repo.sh /tmp/my_repo
```

In a *separate* terminal, chance to the repository's directory.

```bash
$_2 cd /tmp/my_repo
```

You can check the log, it should contain only a single commit for the initial
repository you just created.

```bash
$_2 git log
```

Create and switch to a new branch.

```bash
$_2 git switch -c feature/improve_cli
```

Now you can "work" on this feature, simulated by running the following script:

```bash
$_1 ./work_in_branch.sh /tmp/my_repo
```

Check the work by looking at the log.
```bash
$_2 git log --oneline
```

You will see three additional commits in the branch `feature/improve_cli`.

Now switch back to the main banch to merge the changes in the feature branch
into it

```bash
$_2 git switch main
```

If the repository has an origin (not for this tutorial example), make sure that
the changes to main at origin are merged into the local main.

Skip this for the tutorial, never when there is an origin.

```bash
$_2 git fetch origin
$_2 git merge --ff-only
```

Merge-squash the feature branch into the main branch.

```bash
$_2 git merge --squash feature/improve_cli
```

Now you can commit all changes with the message you like.

```bash
$_2 git commit -m 'Replace sys.argv by argparse command line handling'
```

You can verify that there is only a single additional commit, rather
than three.

```bash
$_2 git log --oneline
```
