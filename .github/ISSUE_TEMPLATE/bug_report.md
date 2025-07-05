---
name: Bug report
about: File a bug report to help us improve PromptDrifter GitHub Action
title: "[BUG]: "
labels: bug, to triage
assignees: ''
type: bug

---

<!--
Thank you for using PromptDrifter GitHub Action! 🎉

Before filing a bug report, please check:
- Have a usage question? Ask in Discussions: https://github.com/Code-and-Sorts/PromptDrifter-action/discussions
- Have an idea for a feature? Use the feature request template instead
- Search existing issues to avoid duplicates
- Check the main PromptDrifter CLI repo for CLI-specific issues: https://github.com/Code-and-Sorts/PromptDrifter

Please provide the information below to help us understand and fix the bug.
-->

## Bug Description
<!-- A clear and concise description of what the bug is -->

## Steps to Reproduce
1. 
2. 
3. 

## Expected Behavior
<!-- What you expected to happen -->

## Actual Behavior
<!-- What actually happened -->

## Minimal Reproduction
<!-- Please provide the minimal workflow configuration that reproduces the issue -->

### GitHub Workflow
```yaml
# Your GitHub workflow using the action
name: Test PromptDrifter
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: Code-and-Sorts/PromptDrifter-action@v0.0.1
        with:
          command: validate  # or other command
          files: your-config.yaml
```

### PromptDrifter Configuration
```yaml
# Your promptdrifter.yaml or test configuration
```

## Environment
- **Action version**: <!-- e.g., v0.0.1, @main, specific commit -->
- **GitHub Runner**: <!-- e.g., ubuntu-latest, windows-latest, macos-latest -->
- **PromptDrifter CLI version**: <!-- If known, from action logs -->
- **Command used**: <!-- validate, run, init, etc. -->

## Additional Context
<!-- Add any other context, screenshots, or logs about the problem -->
