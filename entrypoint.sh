#!/bin/bash

set -e

validate_inputs() {
    if [[ -z "$INPUT_FILES" && "$INPUT_COMMAND" != "init" ]]; then
        echo "Error: 'files' input is required for commands other than 'init'"
        exit 1
    fi
}

setup_api_keys() {
    # Handle both underscore and hyphen formats from GitHub Actions
    [[ -n "$INPUT_OPENAI_API_KEY" ]] && export OPENAI_API_KEY="$INPUT_OPENAI_API_KEY" || true
    [[ -n "$INPUT_CLAUDE_API_KEY" ]] && export CLAUDE_API_KEY="$INPUT_CLAUDE_API_KEY" || true
    [[ -n "$INPUT_GEMINI_API_KEY" ]] && export GEMINI_API_KEY="$INPUT_GEMINI_API_KEY" || true
    [[ -n "$INPUT_QWEN_API_KEY" ]] && export QWEN_API_KEY="$INPUT_QWEN_API_KEY" || true
    [[ -n "$INPUT_GROK_API_KEY" ]] && export GROK_API_KEY="$INPUT_GROK_API_KEY" || true
    [[ -n "$INPUT_DEEPSEEK_API_KEY" ]] && export DEEPSEEK_API_KEY="$INPUT_DEEPSEEK_API_KEY" || true
    [[ -n "$INPUT_MISTRAL_API_KEY" ]] && export MISTRAL_API_KEY="$INPUT_MISTRAL_API_KEY" || true
}


main() {
    echo "Starting PromptDrifter Action with command: $INPUT_COMMAND"

    validate_inputs
    setup_api_keys

    # Build CLI arguments more safely
    local cli_args=()
    case "$INPUT_COMMAND" in
        "init")
            cli_args+=("init")
            [[ -n "$INPUT_DIRECTORY" ]] && cli_args+=("$INPUT_DIRECTORY")
            ;;
        "run")
            cli_args+=("run")
            read -ra FILES <<< "$INPUT_FILES"
            cli_args+=("${FILES[@]}")
            [[ "$INPUT_NO_CACHE" == "true" ]] && cli_args+=("--no-cache")
            [[ -n "$INPUT_CACHE_DB" ]] && cli_args+=("--cache-db" "$INPUT_CACHE_DB")
            [[ -n "$INPUT_CONFIG_DIR" ]] && cli_args+=("--config-dir" "$INPUT_CONFIG_DIR")
            [[ -n "$INPUT_MAX_CONCURRENT" ]] && cli_args+=("--max-concurrent" "$INPUT_MAX_CONCURRENT")
            ;;
        "validate")
            cli_args+=("validate")
            read -ra FILES <<< "$INPUT_FILES"
            cli_args+=("${FILES[@]}")
            ;;
        "test-drift-type")
            cli_args+=("test-drift-type")
            [[ -n "$INPUT_DRIFT_TYPE" ]] && cli_args+=("$INPUT_DRIFT_TYPE")
            [[ -n "$INPUT_EXPECTED" ]] && cli_args+=("$INPUT_EXPECTED")
            [[ -n "$INPUT_ACTUAL" ]] && cli_args+=("$INPUT_ACTUAL")
            ;;
        "migrate")
            cli_args+=("migrate")
            [[ -n "$INPUT_MIGRATE_INPUT" ]] && cli_args+=("$INPUT_MIGRATE_INPUT")
            [[ -n "$INPUT_MIGRATE_OUTPUT" ]] && cli_args+=("--output" "$INPUT_MIGRATE_OUTPUT")
            ;;
        *)
            echo "Error: Unknown command '$INPUT_COMMAND'"
            echo "Available commands: init, run, validate, test-drift-type, migrate"
            exit 1
            ;;
    esac

    echo "Executing: promptdrifter ${cli_args[*]}"

    if promptdrifter "${cli_args[@]}"; then
        echo "PromptDrifter execution completed successfully"
        exit 0
    else
        echo "PromptDrifter execution failed"
        exit 1
    fi
}


main "$@"
