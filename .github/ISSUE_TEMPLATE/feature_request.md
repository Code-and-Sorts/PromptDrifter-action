---
name: Feature request
about: Suggest an idea or enhancement for PromptDrifter GitHub Action
title: "[FEATURE]: "
labels: enhancement
assignees: ''
type: feature

---

<!--
Thank you for using PromptDrifter GitHub Action! 🚀

Before filing a feature request, please check:
- Have a usage question? Ask in Discussions: https://github.com/Code-and-Sorts/PromptDrifter-action/discussions
- Experiencing a bug? Use the bug report template instead
- Search existing issues to see if someone already requested this
- For PromptDrifter CLI features, file issues in the main repo: https://github.com/Code-and-Sorts/PromptDrifter

Please provide the information below to help us understand your feature request.
-->

## Problem Statement
<!-- Is your feature request related to a problem? Describe what the problem is -->

## Proposed Solution
<!-- Describe the solution you'd like to see -->

## Use Case
<!-- Describe how this feature would be used in GitHub workflows. Include specific examples if possible -->

### Example Workflow Usage
```yaml
# How you would like to use this feature in a GitHub workflow
name: Example
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: Code-and-Sorts/PromptDrifter-action@v0.0.1
        with:
          # New feature usage here
```

## Alternatives Considered
<!-- Describe any alternative solutions or features you've considered -->

## Additional Context
<!-- Add any other context, mockups, or examples about the feature request -->

## Implementation Notes
<!-- Optional: If you have ideas about how this could be implemented in the GitHub Action, share them here. Consider:
- New action inputs
- Changes to entrypoint.sh
- Docker image modifications
- Integration with PromptDrifter CLI features
-->
