# Reflog

git's reflog can help you undo changes that are destructive such a hard reset,
or a merge that results in a conflict.


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

You can check the history of the repository using `git log`.

```bash
$ git log --oneline
```

The script `create_repo.sh` has made a number of changes to the repository.
The last commit was unwise, as it undid a lot of work done in the previous
commits.  You want to restore the repository to its state before the last
commit.

Unfortunately, you make a mistake since it was a while since you did this last.
You use the following command.

```bash
$ git reset --hard HEAD~2
```

Whenn you check the log, you notice to your horror that the commit that
improved the CLI handling is gone as well. You should have used `HEAD~1`
instead of `HEAD~2`.

```bash
$ git log --oneline
```

A hard reset is a destructive operation, so you dispair and fear that you lost
all that work.

However, no worries, reflog to the rescue.

Although you can't see the last two commitsin the output of `git log`, they are
still in the repository.  You can see the history of all the commits, including
the ones that are not in the current branch, using `git reflog`.

```bash
$ git reflog
```

You can see the last two commits in the output of `git reflog`.  You can
restore the repository to the state before the last two commits using `git
reset --hard` with the appropriate commit hash or using `HEAD@{1}` which is the
state of the repository before the last reset.Vgq

```bash
$ git reset --hard HEAD@{1}
```

Now you are back to where you wanted to be.

**Important note**: a hard reset may also remove untacked files, so be careful
when using it.  Since git is unaware of these, the reflog won't help you
recover them.
