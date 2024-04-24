--------------------
-- LSP Formatters --
--------------------

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  -- { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
  {
    command = "htmlbeautifier",
    filetypes = { 'html' },
  },
  {
    command = "beautysh",
    filetypes = { "sh", "zsh", "bash" },
  },
  {
    command = "yamlfix",
    filetypes = { "yaml", "yml" },
  },
  {
    command = "fixjson",
    filetypes = { "json" },
  }
}
