local M = {}

---Run isort on the current buffer and reload it
function M.call()
  local bufnr = vim.api.nvim_get_current_buf()
  local fname = vim.api.nvim_buf_get_name(bufnr)

  if fname == "" then
    vim.notify("Buffer has no name – cannot run isort", vim.log.levels.WARN)
    return
  end

  -- Save the file first
  vim.cmd("write")

  -- Run isort; capture any error output
  local cmd = { "isort", "--quiet", fname }
  local ok, err = vim.system(cmd, { cwd = vim.fn.fnamemodify(fname, ":h") }):wait()

  if not ok then
    vim.notify("isort failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
    return
  end

  -- Reload the buffer to show the changes
  vim.cmd("edit")
end

return M
