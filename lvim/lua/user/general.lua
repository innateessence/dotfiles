-- lvim is the global options object
-- vim.opt is the global default vim options object

-----------------
-- General Vim --
-----------------
vim.opt.termguicolors = true -- Enable GUI colors
vim.opt.cmdheight = 2 -- more spaces in the neovim command line

-- Space/Tab configs
vim.opt.expandtab = true -- convert tabs into spaces <Ctrl+V> <TAB> to send real tab.
vim.opt.shiftwidth = 2 -- use 2 space indents by default
vim.opt.softtabstop = 2 -- use 2 space indents by default
vim.opt.tabstop = 2 -- use 2 space indents by default

-- Fold configs
vim.opt.foldmethod = "expr" -- enable expression based folds
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- use treesitter for fold expressions
vim.opt.foldlevelstart = 4 -- Set automatic folds to N levels of indentation

-- Disable search highlight (highlight exists during search, but not after for my config)
vim.opt.hlsearch = false


------------------
-- General Lvim --
------------------
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "nightfox"
-- lvim.colorscheme = "carbonfox"
-- lvim.transparent_window = true
-- lvim.use_icons = false
