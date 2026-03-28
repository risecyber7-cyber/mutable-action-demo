#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <github-username> <repo-url>"
  echo "Example: $0 alice https://github.com/alice/mutable-action-demo.git"
  exit 1
fi

username="$1"
repo_url="$2"

cd "$(dirname "$0")"

current_url="$(git remote get-url origin 2>/dev/null || true)"
if [[ -z "$current_url" ]]; then
  git remote add origin "$repo_url"
elif [[ "$current_url" != "$repo_url" ]]; then
  git remote set-url origin "$repo_url"
fi

perl -0pi -e "s/your-username/$username/g" .github/workflows/mutable-ref-demo.yml

if ! git diff --quiet -- .github/workflows/mutable-ref-demo.yml; then
  git add .github/workflows/mutable-ref-demo.yml
  git commit -m "Set GitHub username in workflow"
fi

echo "Push Version 1:"
echo "  git push -u origin master"
echo
echo "After running the workflow once on GitHub, create Version 2:"
echo "  cp action-v2-example.yml .github/actions/demo-action/action.yml"
echo "  git add .github/actions/demo-action/action.yml"
echo "  git commit -m \"Update action to version 2\""
echo "  git push"
echo
echo "Proof commands:"
echo "  rg -n '@master' .github/workflows/mutable-ref-demo.yml"
echo "  diff -u .github/actions/demo-action/action.yml action-v2-example.yml || true"
