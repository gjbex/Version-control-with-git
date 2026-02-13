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

# get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# create directory for repository
mkdir -p "$target"
cp -r "$SCRIPT_DIR/src" "$target/"

# intialize the repository and do the first commit
cd "$target"
git init
echo '__pycache__/' > .gitignore
git add src .gitignore
git commit -m 'Initial commit'

# create a feature branch
git switch -c feature/improve_cli

# change 1
rm -r src
cp -r "$SCRIPT_DIR/src_01/" ./src/
git commit -a -m 'Replace sys.argv with argparse'

# change 2
rm -r src
cp -r "$SCRIPT_DIR/src_02/" ./src/
git commit -a -m 'Add help messsage to command line arguments'

# change 3
rm -r src
cp -r "$SCRIPT_DIR/src_03/" ./src/
git commit -a -m 'Remove unnecessary import'

# switch back to main branch
git switch main

# change in main that will cause conflict when merging feature branch
rm -r src
cp -r "$SCRIPT_DIR/src_04/" ./src/
