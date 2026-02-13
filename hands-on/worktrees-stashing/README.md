# Worktrees and stashing

Worktrees help you quickly work on a different branch without having to
interrupt the work you are currently doing on a different branch.

Although the same can be accomplished by stashing worktrees offer a
cleaner alternative.


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

You are currently working on `src/hello.py`, and it is not in a state to be
committed.  However, you have to make an urgent modification to the code in
the `feature/improve_cli` branch, what do you do?

When you try to switch to the branch `feature/improve_cli`, you get an error.

```bash
$ git switch feature/improve_cli
error: Your local changes to the following files would be overwritten by
        checkout:
        src/hello.py
Please commit your changes or stash them before you switch branches.
```

You have three options:

* do a bad commit of `src/hello.py` and live with it;

* create a new worktree based on `feature/improve_cli`, make the changes you
  want, commit and return to the work at hand;
* stash changes in the working directory, switch to the `feature/improve_cli`
  branch, do your work, commit, switch back to the `main` branch and pop the
  stash.

Since the first scenario is straightforward, but bad practice, we will only
consider worktrees and stashing here.


## Scenario A: worktrees

To keep the current work tree as is, you can add a new one in a different
directory (not in the repository itself).

```bash
$ git worktree add /tmp/my_repo_quick_fix feature/improve_cli
```

Now you have two worktrees, you can list all worktress.

```bash
git worktree list
```

To use the newly added worktrees, change to its directory.

```bash
cd /tmp/my_repo_quick_fix
```

You can check that the active branch is `feature/improve_cli`, it will be
marked with an `*`.

```
git branch
```

You can now make any changes you want and commit.  Once you are done,
change back to the original worktree.

```bash
cd /tmp/my_repo
```

You will be back where you were, in the `main` branch and can continue
your work there.

However, you should first clear up the other worktree.

```bash
$ git worktree remove /tmp/my_repo_quick_fix
$ git worktree prune
```

Although this is by far the most convenient approach, you can also follow
a second scenario.


## Scenario B: stashing

Remove the directory to reecreate the repository.

```bash
rm -rf /tmp/my_repo
./create_repo.sh /tmp/my_repo
```

You are back in the same situation as at the start of scenario A.

Since you can't switch to `feature/improve_cli` without overwriting
`src/hello.py`, and don't want a bad commit, you can opt to stash
your changes.

```bash
$ git stash push
```

All changes you made have now been stashed away, and your working
directory is clean.  You can verify this.

```bash
git status
```

It is now perfectly safe to switch to the branch `feature/improve_cli`.

```bash
$ git switch feature/improve_cli
```

Again, you can make all the changes you like and commit.  Once this
is done, you can switch back to the `main` branch.

```bash
$ git switch main
```

Again, your working directory is clean.  However, you stashed some
changes.  You can list the staches using:

```bash
$ git stash list
```

You can get more details on a stash using:


```bash
$ git stash show
```

To get back to where you were, simply pop the stash.

```bash
$ git stash pop
```

You can ocntinue to work on the `main` branch as if there had been no
interruption.
