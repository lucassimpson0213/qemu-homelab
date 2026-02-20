set shell := ["bash", "-eu", "-o", "pipefail", "-c"]
set working-directory := "vmctl"

# Adjust if your base branch is main
BASE := "main"

default:
    just --list

# Create a correctly named branch off BASE
# Usage: just feat 123 "page allocator"
feat issue desc:
    git switch {{BASE}}
    git pull
    slug=$(echo "{{desc}}" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g'); \
    branch="feat/{{issue}}-$slug"; \
    git switch -c "$branch"; \
    git push -u origin "$branch"

# One command to keep you honest
check:
    cargo fmt --all
    cargo clippy --all-targets -- -D warnings
    cargo test

# Guard: enforce branch naming (feat/* only, minimal)
guard:
    b=$(git rev-parse --abbrev-ref HEAD); \
    [[ "$b" =~ ^feat/[0-9]+-[a-z0-9-]+$ ]] || (echo "Bad branch: $b (expected feat/<issue>-<slug>)" && exit 1)

# The “only way you commit”
commit msg: guard check
    git add -A
    git commit

push:
    git push
