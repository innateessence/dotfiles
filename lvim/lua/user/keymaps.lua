------------------
-- Key Mappings --
------------------

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["L"] = "<cmd>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["H"] = "<cmd>BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

------------------------
-- Which Key Mappings --
------------------------

-- Removed mappings
-- lvim.builtin.which_key.mappings['w'] = {}
-- lvim.builtin.which_key.mappings['q'] = {}
-- lvim.builtin.which_key.mappings['h'] = {}
-- lvim.builtin.which_key.mappings['/'] = {}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["d"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

lvim.builtin.which_key.mappings["C"] = {
  name = "Codi",
  C = { "<cmd>Codi<cr>", "Codi Enable" },
  c = { "<cmd>Codi!<cr>", "Codi Disable" },
  d = { "<cmd>CodiExpand<cr>", "Codi expand debug info" },
}

lvim.builtin.which_key.mappings['g']['B'] = {"<cmd>GitBlameToggle<CR>", "Git Blame Toggle"}
lvim.builtin.which_key.mappings['l']['R'] = {"<cmd>LspRestart<CR>", "Restart LSP"}
lvim.builtin.which_key.mappings['`'] = {"<cmd>Term<CR>", "Terminal"}
