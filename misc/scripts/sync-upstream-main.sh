#!/usr/bin/env bash

set -euo pipefail

BASE_BRANCH="${1:-uef}"
UPSTREAM_REMOTE="${UPSTREAM_REMOTE:-upstream}"
UPSTREAM_BRANCH="${UPSTREAM_BRANCH:-main}"
SYNC_PREFIX="${SYNC_PREFIX:-sync/upstream-main}"
OPEN_PR="${OPEN_PR:-0}"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "This script must run inside a git repository"
  exit 1
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  echo "Missing origin remote"
  exit 1
fi

if ! git remote get-url "$UPSTREAM_REMOTE" >/dev/null 2>&1; then
  git remote add "$UPSTREAM_REMOTE" https://github.com/keycloak/keycloak.git
fi

git fetch origin "$BASE_BRANCH"
git fetch "$UPSTREAM_REMOTE" "$UPSTREAM_BRANCH"
git checkout -B "$BASE_BRANCH" "origin/$BASE_BRANCH"

if git merge-base --is-ancestor "$UPSTREAM_REMOTE/$UPSTREAM_BRANCH" HEAD; then
  echo "No sync needed: $BASE_BRANCH already contains $UPSTREAM_REMOTE/$UPSTREAM_BRANCH"
  exit 0
fi

timestamp="$(date -u +%Y%m%d-%H%M%S)"
sync_branch="$SYNC_PREFIX-$timestamp"

git checkout -b "$sync_branch"

if ! git merge --no-ff --no-edit "$UPSTREAM_REMOTE/$UPSTREAM_BRANCH"; then
  echo "Merge conflict while syncing from $UPSTREAM_REMOTE/$UPSTREAM_BRANCH"
  echo "Resolve conflicts on branch $sync_branch, then push and open PR manually"
  exit 2
fi

git push -u origin "$sync_branch"
echo "Created and pushed $sync_branch"

if [[ "$OPEN_PR" == "1" ]]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "gh CLI not found, skipping automatic PR creation"
    exit 0
  fi

  gh pr create \
    --base "$BASE_BRANCH" \
    --head "$sync_branch" \
    --title "chore(sync): merge $UPSTREAM_REMOTE/$UPSTREAM_BRANCH into $BASE_BRANCH" \
    --body "Automated upstream sync created by misc/scripts/sync-upstream-main.sh"
fi
