-------------------
-- Auto Commands --
-------------------

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "enable wrap mode for specific files only",
  pattern = { "json", "yaml", "text" },
  command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Dynamically add <leader>M to view markdown file in `glow`",
  pattern = "markdown",
  callback = function()
    lvim.builtin.which_key.mappings["M"] = { "<cmd>Glow<CR>", "Markdown" }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Use 4 spaces for tabs on python files",
  pattern = "python",
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
    vim.opt.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "let treesitter use bash highlight for zsh files as well",
  pattern = "zsh",
  callback = function()
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = "_general_settings",
--   pattern = "lvim/**.lua",
--   desc = "Trigger LvimReload on saving any lvim .lua file",
--   callback = function()
--     require('lvim.plugin-loader'):recompile()
--     require("lvim.config"):reload()
--     print("[+] Detected Lvim config write. Reloaded")
--   end,
-- })
