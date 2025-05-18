local clangd_flags = {
  "--all-scopes-completion",
  "--suggest-missing-includes",
  "--background-index",
  "--pch-storage=disk",
  "--cross-file-rename",
  "--log=info",
  "--completion-style=detailed",
  "--enable-config",          -- clangd 11+ supports reading from .clangd configuration file
  "--clang-tidy",
  "--offset-encoding=utf-16", --temporary fix for null-ls
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  -- "--fallback-style=Google",
  -- "--header-insertion=never",
  -- "--query-driver=<list-of-white-listed-complers>"
}

local clangd_bin = "clangd"

local opts = {
  cmd = { clangd_bin, unpack(clangd_flags) },
}
require("lvim.lsp.manager").setup("clangd", opts)

vim.opt.shiftwidth = 2 -- use 2 space indents by default
vim.opt.softtabstop = 2 -- use 2 space indents by default
vim.opt.tabstop = 2 -- use 2 space indents by default
