-- This is the init file for LunarVim.
-- This will `source` the files in ~/.config/lvim/lua/user/*.lua
-- Nice and modular and clean. Just the way things should be.

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" }) -- specific rust edgecase. Keep me.

require("user.general")
require("user.plugins")
require("user.lsp")
require("user.keymaps")
require("user.autocmds")
require("user.commands")
require("user.langs.rust") -- Just do it.
