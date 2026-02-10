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
echo '__pycache__/' > .gitignore
git add src .gitignore
git commit -m 'Initial commit'
