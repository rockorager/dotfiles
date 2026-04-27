function load_ai_keys --description 'Load AI API keys from 1Password via opcache into this shell'
    set -gx ANTHROPIC_API_KEY (opcache read "op://Private/Anthropic API Key/credential")
    or return $status

    set -gx OPENAI_API_KEY (opcache read "op://Private/OpenAI API Key/credential")
    or return $status
end
