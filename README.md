# Mutable GitHub Action Reference Demo

This demo shows that a workflow can execute different action code without any change to the workflow file when it references a mutable branch such as `@master`.

## Files

- `.github/actions/demo-action/action.yml`: initial action implementation
- `.github/workflows/mutable-ref-demo.yml`: workflow that uses the action via `@master`
- `action-v2-example.yml`: replacement action implementation for the second run

## How to run

1. Create a repository such as `your-username/mutable-action-demo`.
2. Copy `.github/actions/demo-action/action.yml` and `.github/workflows/mutable-ref-demo.yml` into that repository.
3. Replace `your-username` in the workflow with your GitHub username or org.
4. Commit and push the initial version to the `master` branch.
5. Run the workflow manually from the Actions tab.
6. Replace `.github/actions/demo-action/action.yml` with the contents of `action-v2-example.yml`.
7. Commit and push again to the same `master` branch.
8. Re-run the workflow.

The workflow file stays the same, but the output changes because `@master` resolves to the latest commit on that branch each time the job starts.
