#!/bin/bash

set -e

validate_inputs() {
    if [[ -z "$INPUT_FILES" && "$INPUT_COMMAND" != "init" ]]; then
        echo "Error: 'files' input is required for commands other than 'init'"
        exit 1
    fi
}

setup_api_keys() {
    [[ -n "$INPUT_OPENAI_API_KEY" ]] && export OPENAI_API_KEY="$INPUT_OPENAI_API_KEY"
    [[ -n "$INPUT_CLAUDE_API_KEY" ]] && export CLAUDE_API_KEY="$INPUT_CLAUDE_API_KEY"
    [[ -n "$INPUT_GEMINI_API_KEY" ]] && export GEMINI_API_KEY="$INPUT_GEMINI_API_KEY"
    [[ -n "$INPUT_QWEN_API_KEY" ]] && export QWEN_API_KEY="$INPUT_QWEN_API_KEY"
    [[ -n "$INPUT_GROK_API_KEY" ]] && export GROK_API_KEY="$INPUT_GROK_API_KEY"
    [[ -n "$INPUT_DEEPSEEK_API_KEY" ]] && export DEEPSEEK_API_KEY="$INPUT_DEEPSEEK_API_KEY"
    [[ -n "$INPUT_MISTRAL_API_KEY" ]] && export MISTRAL_API_KEY="$INPUT_MISTRAL_API_KEY"
}

build_cli_args() {
    local args=()

    case "$INPUT_COMMAND" in
        "init")
            args+=("init")
            [[ -n "$INPUT_DIRECTORY" ]] && args+=("$INPUT_DIRECTORY")
            ;;
        "run")
            args+=("run")
            read -ra FILES <<< "$INPUT_FILES"
            args+=("${FILES[@]}")
            [[ "$INPUT_NO_CACHE" == "true" ]] && args+=("--no-cache")
            [[ -n "$INPUT_CACHE_DB" ]] && args+=("--cache-db" "$INPUT_CACHE_DB")
            [[ -n "$INPUT_CONFIG_DIR" ]] && args+=("--config-dir" "$INPUT_CONFIG_DIR")
            [[ -n "$INPUT_MAX_CONCURRENT" ]] && args+=("--max-concurrent" "$INPUT_MAX_CONCURRENT")
            ;;
        "validate")
            args+=("validate")
            read -ra FILES <<< "$INPUT_FILES"
            args+=("${FILES[@]}")
            ;;
        "test-drift-type")
            args+=("test-drift-type")
            [[ -n "$INPUT_DRIFT_TYPE" ]] && args+=("$INPUT_DRIFT_TYPE")
            [[ -n "$INPUT_EXPECTED" ]] && args+=("$INPUT_EXPECTED")
            [[ -n "$INPUT_ACTUAL" ]] && args+=("$INPUT_ACTUAL")
            ;;
        "migrate")
            args+=("migrate")
            [[ -n "$INPUT_MIGRATE_INPUT" ]] && args+=("$INPUT_MIGRATE_INPUT")
            [[ -n "$INPUT_MIGRATE_OUTPUT" ]] && args+=("--output" "$INPUT_MIGRATE_OUTPUT")
            ;;
        *)
            echo "Error: Unknown command '$INPUT_COMMAND'"
            echo "Available commands: init, run, validate, test-drift-type, migrate"
            exit 1
            ;;
    esac

    echo "${args[@]}"
}

main() {
    echo "Starting PromptDrifter Action with command: $INPUT_COMMAND"

    validate_inputs
    setup_api_keys

    cli_args=($(build_cli_args))

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
