# Changing your mind

There are various ways to fix unwise commits in a git repository. The most
common are:

* git reset
* git revert
* git checkout
* git rebase

To experiment with these commands, you can create a new repository that has a
number of commits that you can change.


## What is it?

1. `create_repo.sh`: Bash script to create a new git repository with a number of commits.
1. `src`, `src_01`, ..., `src_10`: Directories containing source code for each commit.


## How to use it?

Create the repository:
```bash
$ mkdir ~/my_repo
$ ./create_repo.sh ~/my_repo
$ cd ~/my_repo
```

You can check the commits with:
```bash
$ git log
```

You can try to run the `hello.py` script as follows:
```bash
$ python src/hello.py --repeat 10 world
```

The script will fail with the following error message:
```bash
Traceback (most recent call last):
  File "/home/gjb/tmp/my_repo/src/hello.py", line 23, in <module>
    main()
  File "/home/gjb/tmp/my_repo/src/hello.py", line 14, in main
    say_hello = messenger_factory.create_messenger('Hello')
  File "/home/gjb/tmp/my_repo/src/messenger_factory.py", line 24, in create_messenger
    @functools.wraps(say_something)
NameError: name 'functools' is not defined
```

Clearly, it was a Bad Idea(tm) to remove the import of `functools` in
`src/messenger_factory.py`.

This can be fixed in multiple ways, depending on the context.  In any case,
you will need to know the commit that worked before the change was made. You
can find this by looking at the commit history:

```bash
$ git log --oneline
4839138 (HEAD -> main) Fix typo in factory name
cc3c42e Remove utils module
73c32c2 Fix comment
7684fd7 Fix comment and string capitalization
2d20068 Use factory in bye application
30b0445 Use factory in hello application
9b23c78 Remove unnecessary import
d3f4e5a Add module with messenger factory
533f5c4 Add repetion argument to the bye application
96fac2e Add repetion argument to the hello application
233fbdc Initial commit
```

The commit that worked is the one before that with the commit message
"`Remove unnecessary import`".  You have to check this for yourself since the
commit ID will be different in your repository.  For this example, it is
`d3f4e5a`.  The commit in which the import was removed is `9b23c78` in this
example.  To summarize:

* `d3f4e5a` has the correct version of `messanger_factory.py`,
* `9b23c78` has the incorrect version of `messanger_factory.py`.

**Note:** commit IDs will be different in your repository.


### Restore the commit that worked

You can fix this by restoring the commit that worked. This can be done with `git restore`:

```bash
$ git restore --source=d3f4e5a src/messanger_factory.py
```

Note that you have to use the file name that this module had in the commit that worked, which is `messanger_factory.py` in this case.

Since the last commit changed the file name to `messenger_factory.py`, you will have to rename it back to the old name:

```bash
$ mv src/messanger_factory.py src/messenger_factory.py
```

This can alternatively be done with
```bash
$ git show d3f4e5a:src/messanger_factory.py > src/messenger_factory.py
```

Note that this would not restore file permissions, which in this case is not
an issue, but in general it is better to use `git restore` to restore files.

Now you can commit the change:

```bash
$ git add src/messenger_factory.py
$ git commit -m "Restore import of functools"
```


### Revert the commit

You can also revert the commit that broke it. This can be done with `git
revert`.  In this case, you need to know the commit ID of the commit that
broke it, which is `9b23c78` in this example.    

```bash
$ git revert -n 9b23c78
$ git commit -m "Revert commit that removed import of functools"
```

You can omit the `-n` option to start a new commit immediately.


### Reset to the commit that worked

You can also reset the repository to the commit that worked. This can be done
with `git reset`.  In this case, you need to know the commit ID of the commit
that worked, which is `d3f4e5a` in this example.

```bash
$ git reset --hard d3f4e5a
```

This will reset the repository to the commit that worked, and all changes made
after that commit will be lost.  This is a destructive operation, so be careful
with it.  If you want to keep the changes made after that commit, you can use  
the following command instread:
```bash
$ git reset --soft d3f4e5a
```

This will keep the changes in the working directory and the index, but reset
the commit history to the commit that worked.  Note that one of the changes
kept is the removal of `functools` import, so this solution would require
you to review changes carefully before committing them.

You can experiment with it in the repository (create it again), but this is
probably not what you want to do in this situation.

`git reset` is most useful to undo the last commit(s) when you don't want to
keep any later commits.

**Note:** Bare in mind that `git reset` is a destructive operation.

### Rewriting history

Another approach would be to remove the offending commit from the history while
keeping subsequent commits.  This would work in this case because the offending
commit is atomic and only contains the change that caused the issue.  In
general, this may prove more difficult.

```bash
$ git rebase --onto d3f4e5a 9b23c78 main
```

This will remove the bad commit `9b23c78`, and apply all subsequent commit to
the previous commit `d3f4e5a`.

You can verify this easily:

```bash
$ git log --oneline
4839138 (HEAD -> main) Fix typo in factory name
cc3c42e Remove utils module
73c32c2 Fix comment
7684fd7 Fix comment and string capitalization
2d20068 Use factory in bye application
30b0445 Use factory in hello application
d3f4e5a Add module with messenger factory
533f5c4 Add repetion argument to the bye application
96fac2e Add repetion argument to the hello application
233fbdc Initial commit
```

**Note:** Bare in mind that `git rebase` is a destructive operation.
