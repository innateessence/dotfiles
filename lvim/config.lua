-- This is the init file for LunarVim.
-- This will `source` the files in ~/.config/lvim/lua/user/*.lua
-- Nice and modular and clean. Just the way things should be.

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
-- require("user.langs.rust") -- Just do it.

-- Copilot test drive.
table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  lazy = false,
  config = function()
    vim.defer_fn(function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
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
