return {
  {
    "hrsh7th/nvim-cmp",
    optional = true,

    opts = function(_, opts)
      opts.sources = opts.sources or {}

      -- Register Ollama completions (single-line only)
      table.insert(opts.sources, 1, {
        name = "minuet",
        priority = 100,
        group_index = 1,

        entry_filter = function(entry)
          local item = entry:get_completion_item()
          local text = item.insertText
            or (item.textEdit and item.textEdit.newText)
            or item.label
            or ""

          return not text:find("\n", 1, true)
        end,
      })

      opts.performance = opts.performance or {}
      opts.performance.fetching_timeout = 2000
    end,
  },
}

