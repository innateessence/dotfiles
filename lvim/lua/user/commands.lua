local M = {}

-- Define functions
M.ToggleHighlight = function()
  local hl = vim.opt.hlsearch.get(vim.opt.hlsearch)
  vim.opt.hlsearch = not hl
  if hl then
    print("Enabled hlsearch")
  else
    print("Disabled hlsearch")
  end
end

-- define Vim commands (vimscript)
-- vim.cmd([[command! CommandName lua FunctionName('%s/\\s\\+$//ge')]])

-- define Vim commands (lua functions)
-- vim.api.nvim_create_user_command('CommandName', M.FunctionName, {arguments})
vim.api.nvim_create_user_command('ToggleHighlight', M.ToggleHighlight, {})
vim.api.nvim_create_user_command('Term', 'TermExec cmd="clear"', {}) -- sometimes I just want a quick terminal overtop my code.

return M
