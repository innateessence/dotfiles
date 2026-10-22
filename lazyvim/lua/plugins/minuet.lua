
return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",

    opts = {
      provider = "openai_fim_compatible",

      -- Optimize for low latency
      add_single_line_entry = true,
      n_completions = 3,
      context_window = 1024,
      request_timeout = 5,
      throttle = 100,
      debounce = 100,
      add_single_line_entry = true,

      cmp = {
        enable_auto_complete = true,
      },

      -- Use nvim-cmp instead of ghost text
      virtualtext = {
        auto_trigger_ft = {},
      },

      provider_options = {
        openai_fim_compatible = {
          name = "Ollama",
          api_key = "TERM",
          end_point = "http://192.168.1.200:11434/v1/completions",
          model = "qwen2.5-coder:7b",
          optional = {
            max_tokens = 64,
            temperature = 0.2,
            top_p = 0.9,
          },
        },
      },
    },
  },
}

