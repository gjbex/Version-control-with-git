#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <target_directory>" >&2
    exit 1
fi

check_git_repo() {
    local dir="$1"
    while [[ "$dir" != "/" && -n "$dir" ]]; do
        if [[ -d "$dir/.git" ]]; then
            return 0
        fi
        dir=$(dirname "$dir")
    done
    return 1
}

target="$1"
if realpath_out=$(realpath "$target" 2>/dev/null); then
    target="$realpath_out"
fi

if check_git_repo "$target"; then
    echo "Error: the directory '$target' is already part of a Git repository." >&2
    exit 1
fi

# create directory for repository
mkdir -p "$target"
cp -r src "$target/"

# get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# intialize the repository and do the first commit
cd "$target"
git init
git add src
git commit -m 'Initial commit'

# change 1
rm -r src
cp -r "$SCRIPT_DIR/src_01/" ./src/
git commit -a -m 'Add repetion argument to the hello application'

# change 2
rm -r src
cp -r "$SCRIPT_DIR/src_02/" ./src/
git commit -a -m 'Add repetion argument to the bye application'

# change 3
rm -r src
cp -r "$SCRIPT_DIR/src_03/" ./src/
git add src/messanger_factory.py
git commit -m 'Add module with messenger factory'

# change 4
rm -r src
cp -r "$SCRIPT_DIR/src_04/" ./src/
git commit -a -m 'Remove unnecessary import'

# change 5
rm -r src
cp -r "$SCRIPT_DIR/src_05/" ./src/
git commit -a -m 'Use factory in hello application'

# change 6
rm -r src
cp -r "$SCRIPT_DIR/src_06/" ./src/
git commit -a -m 'Use factory in bye application'

# change 7
rm -r src
cp -r "$SCRIPT_DIR/src_07/" ./src/
git commit -a -m 'Fix comment and string capitalization'

# change 8
rm -r src
cp -r "$SCRIPT_DIR/src_08/" ./src/
git commit -a -m 'Fix comment'

# change 9
git rm src/utils.py
git commit -m 'Remove utils module'

# change 10
rm -r src
cp -r "$SCRIPT_DIR/src_10/" ./src/
git mv src/messanger_factory.py src/messenger_factory.py
git commit -a -m 'Fix typo in factory name'
