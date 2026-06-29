if __is_mac; then
  # Claude Code - use local model
  export ANTHROPIC_BASE_URL=http://192.168.1.200:11434
  export ANTHROPIC_AUTH_TOKEN=ollama
  export ANTHROPIC_API_KEY=""
  alias claude="claude --model qwen3-coder:30b"
fi
