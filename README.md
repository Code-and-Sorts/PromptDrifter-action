# Run PromptDrifter Tests GitHub Action

This GitHub Action runs your [PromptDrifter](https://github.com/CodeAndSorts/PromptDrifter) tests as part of your CI/CD workflow.

## Usage

To use this action in your workflow, add the following step. This example assumes your PromptDrifter YAML test files are in a directory called `tests` and your workflow checks out your repository first.

```yaml
name: PromptDrifter CI

on: [push, pull_request]

jobs:
  test_prompts:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Run PromptDrifter tests
        uses: CodeAndSorts/promptdrifter-action@v1 # Replace with the correct action repository and version tag
        with:
          test-files: './tests/*.yaml' # Glob pattern for your test files
          # Optional inputs:
          # promptdrifter-version: '0.0.1' # Or 'main' to use the latest from git, or 'latest' for PyPI
          # config-dir: './pd_config'
          # no-cache: 'true'
          # cache-db-path: '.custom_cache.db'
          # working-directory: './sub_project'
```

## Inputs

| Input                   | Description                                                                                          | Required | Default                      |
|-------------------------|------------------------------------------------------------------------------------------------------|----------|------------------------------|
| `test-files`            | Glob pattern for the PromptDrifter YAML test files to run (e.g., `./tests/*.yaml`, `my_tests.yaml`). | `true`   | N/A                          |
| `promptdrifter-version` | The version of PromptDrifter to install (e.g., `0.1.0`, `latest` for PyPI, or a git ref like `main`).| `false`  | `latest`                     |
| `config-dir`            | Directory containing PromptDrifter configuration files.                                              | `false`  | `.` (working directory)      |
| `no-cache`              | Set to `'true'` to disable PromptDrifter's response caching.                                         | `false`  | `'false'`                    |
| `cache-db-path`         | Path to a custom cache database file.                                                                | `false`  | (PromptDrifter's default)    |
| `working-directory`     | The directory from which to run the `promptdrifter` command. Useful if test files are in a sub-path. | `false`  | `.` (repository root)        |

## Contributing

Contributions are welcome! Please open an issue or pull request in this action's repository.

## License

This action is licensed under the [MIT License](LICENSE). (Or specify the chosen license)
