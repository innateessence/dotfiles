-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  desc = "Treat zsh files as bash",
  pattern = { "zsh" },
  callback = function()
    vim.treesitter.start(0, "bash") -- use bash treesitter parser
    vim.bo.filetype = "bash" -- set filetype to bash for this buffer
  end,
})
