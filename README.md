# PromptDrifter GitHub Action

Docker-based GitHub Action for running [PromptDrifter](https://github.com/Code-and-Sorts/PromptDrifter) tests in CI/CD workflows to detect prompt drift and LLM response changes.

## Features

- 🔍 **Drift Detection**: Catch when LLM responses change unexpectedly
- 🚀 **CI Integration**: Fail builds when prompt drift is detected
- 🔐 **Secure**: API keys handled via GitHub secrets
- 📋 **Multiple Formats**: Support for various drift detection types
- ⚡ **Fast**: Built-in caching for faster subsequent runs
- 🌐 **Multi-Provider**: Support for OpenAI, Claude, Gemini, and more

## Usage

### Basic Example

```yaml
name: PromptDrifter Tests
on: [push, pull_request]

jobs:
  prompt-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: Code-and-Sorts/PromptDrifter-action@v0.0.1
        with:
          files: 'tests/promptdrifter.yaml'
          openai-api-key: ${{ secrets.OPENAI_API_KEY }}
```

### Advanced Example

```yaml
name: Multi-Provider Prompt Tests
on: [push, pull_request]

jobs:
  prompt-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: Code-and-Sorts/PromptDrifter-action@v0.0.1
        with:
          files: |
            tests/openai-tests.yaml
            tests/claude-tests.yaml
            tests/gemini-tests.yaml
          openai-api-key: ${{ secrets.OPENAI_API_KEY }}
          claude-api-key: ${{ secrets.CLAUDE_API_KEY }}
          gemini-api-key: ${{ secrets.GEMINI_API_KEY }}
          no-cache: 'false'
          max-concurrent: '5'
```

### Initialize Configuration

```yaml
- name: Initialize PromptDrifter
  uses: Code-and-Sorts/PromptDrifter-action@v0.0.1
  with:
    command: 'init'
    directory: './prompt-tests'
```

### Validate Configuration Files

```yaml
- name: Validate Configurations
  uses: Code-and-Sorts/PromptDrifter-action@v0.0.1
  with:
    command: 'validate'
    files: 'config/*.yaml'
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `command` | PromptDrifter command to run (`init`, `run`, `validate`, `test-drift-type`, `migrate`) | No | `run` |
| `files` | Space-separated list of configuration files | Yes (for most commands) | - |
| `directory` | Directory for init command | No | `.` |
| `openai-api-key` | OpenAI API key | No | - |
| `claude-api-key` | Anthropic Claude API key | No | - |
| `gemini-api-key` | Google Gemini API key | No | - |
| `qwen-api-key` | Qwen API key | No | - |
| `grok-api-key` | Grok API key | No | - |
| `deepseek-api-key` | DeepSeek API key | No | - |
| `mistral-api-key` | Mistral API key | No | - |
| `no-cache` | Disable response caching | No | `false` |
| `max-concurrent` | Maximum concurrent tests | No | `10` |
| `config-dir` | Directory containing config files | No | `.` |
| `cache-db` | Path to cache database | No | - |
| `drift-type` | Drift type for testing | No | - |
| `expected` | Expected value for drift testing | No | - |
| `actual` | Actual value for drift testing | No | - |
| `migrate-input` | Input file for migration | No | - |
| `migrate-output` | Output file for migration | No | - |

## Outputs

| Output | Description |
|--------|-------------|
| `result` | Result of the PromptDrifter execution |

## Configuration

Create a `promptdrifter.yaml` file in your repository:

```yaml
version: "0.1"
providers:
  - name: openai
    model: gpt-4o-mini
    api_key: env:OPENAI_API_KEY

tests:
  - name: "Basic greeting test"
    prompt: "Say hello"
    expected: "Hello!"
    assertion: exact_match
```

For detailed configuration options, see the [PromptDrifter documentation](https://github.com/Code-and-Sorts/PromptDrifter).

## Security

- Store API keys in GitHub repository secrets
- Never commit API keys to your repository
- API keys are passed as environment variables to Docker container

## Docker Action Structure

```
├── action.yml          # Action metadata (using: 'docker')
├── Dockerfile          # Python + PromptDrifter installation
├── entrypoint.sh       # Shell script that calls promptdrifter CLI
└── README.md          # This file
```

## License

MIT License - see [LICENSE](LICENSE) file for details.