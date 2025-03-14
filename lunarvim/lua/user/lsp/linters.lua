-----------------
-- LSP Linters --
-----------------

-- Linters should be
-- filled in as strings with either
-- a global executable or a path to
-- an executable

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup {
  -- {
  --   command = "flake8",
  --   filetypes = { "python" },
  --   extra_args = { '--ignore',
  --     "E121,E122,E123,E124,E125,E126,E127,E128,E129,E131,E265,E266,E402,E501,E722,E731,E741,W503,W504" },
  -- },
  -- {
  --   command = "mypy",
  --   filetypes = { "python" },
  -- },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    extra_args = { "--severity", "error", "--exclude", "SC2015,SC2006" },
    filetypes = { "sh", "zsh", "bash" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python", "html", "bash", "zsh", "sh" },
  },
  {
    command = "yamllint",
    filetypes = { "yaml", "yml" },
  },
  -- {
  --   command = "markdownlint",
  --   extra_args = { "--disable", "MD033", "--disable", "MD041" },
  --   filetypes = { "html", "markdown" },
  -- },
  -- {
  --   command = "markuplint",
  --   filetypes = { "html" },
  -- },
  {
    command = "jsonlint",
    filetypes = { "json" },
  }
}
