-- This is the init file for LunarVim.
-- This will `source` the files in ~/.config/lvim/lua/user/*.lua

-- NOTE: Enable this when using rust
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" }) -- specific rust edgecase. Keep me.

require("user.general")
require("user.plugins.defaults")
require("user.plugins.telescope")
require("user.plugins.treesitter")
require("user.plugins.plugins")
require("user.lsp.general")
require("user.lsp.formatters")
require("user.lsp.linters")
require("user.keymaps")
require("user.autocmds")
require("user.commands")
require("user.langs.rust") -- Just do it.
-- require("user.langs.c")

-- Copilot test drive.
table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  lazy = false,
  config = function()
    vim.defer_fn(function()
      require("copilot").setup({
        suggestion = { enabled = true },
        panel = { enabled = true },
      })                             -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
})

-- WSL Clipboard support.
if vim.fn.has('wsl') == 1 then
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('Yank', { clear = true }),
    callback = function()
      vim.fn.system('clip.exe', vim.fn.getreg('"'))
    end,
  })
end


-- add `pyright` to `skipped_servers` list
-- remove `jedi_language_server` from `skipped_servers` list
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "ruff_lsp"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

vim.g.python3_host_prog = '/home/brenden/.pyenv/versions/3.10.13/bin/python3'

-- local pyright_opts = {
--   single_file_support = true,
--   settings = {
--     pyright = {
--       disableLanguageServices = true,
--       disableOrganizeImports = false
--     },
--     python = {
--       analysis = {
--         autoImportCompletions = true,
--         autoSearchPaths = true,
--         diagnosticMode = "workspace", -- openFilesOnly, workspace
--         typeCheckingMode = "basic", -- off, basic, strict
--         useLibraryCodeForTypes = true
--       }
--     }
--   },
-- }

-- require("lvim.lsp.manager").setup("pyright", pyright_opts)

-- -- Example LunarVim config for pyright LSP
-- local lspconfig = require('lspconfig')

-- lspconfig.pyright.setup{
--   settings = {
--     pyright = {
--       disableLanguageServices = true,
--     },
--     python = {
--       analysis = {
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--       },
--     },
--   },
-- }

