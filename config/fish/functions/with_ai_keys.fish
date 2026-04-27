function with_ai_keys --description 'Run a command with AI API keys loaded from 1Password via opcache'
    if test (count $argv) -eq 0
        echo "Usage: with_ai_keys COMMAND [ARGS...]" >&2
        return 2
    end

    set -lx ANTHROPIC_API_KEY (opcache read "op://Private/Anthropic API Key/credential")
    or return $status

    set -lx OPENAI_API_KEY (opcache read "op://Private/OpenAI API Key/credential")
    or return $status

    $argv
end
