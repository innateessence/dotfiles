-- Rust tools requires setup outside of the config function for now...

-- -- More Rust config: https://github.com/LunarVim/starter.lvim/tree/rust-ide

local rust_plugins = {
  "simrat39/rust-tools.nvim",
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
}

table.insert(lvim.plugins, rust_plugins)

local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
  return
end
local opts = {
  tools = {
    executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
    reload_workspace_from_cargo_toml = true,
    inlay_hints = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "<-",
      other_hints_prefix = "=>",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
    hover_actions = {
      --border = {
      --        { "╭", "FloatBorder" },
      --        { "─", "FloatBorder" },
      --        { "╮", "FloatBorder" },
      --        { "│", "FloatBorder" },
      --        { "╯", "FloatBorder" },
      --        { "─", "FloatBorder" },
      --        { "╰", "FloatBorder" },
      --        { "│", "FloatBorder" },
      --},
      auto_focus = true,
    },
  },
  server = {
    on_attach = require("lvim.lsp").common_on_attach,
    on_init = require("lvim.lsp").common_on_init,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        }
      }
    },
  },
}
rust_tools.setup(opts)

vim.api.nvim_create_autocmd("FileType", {
  desc = "Override LSP keybinds with rust specifics",
  pattern = "rust",
  callback = function()
    lvim.builtin.which_key.mappings["R"] = {
      name = "Rust",
      r = { "<cmd>RustRunnables<Cr>", "Runnables" },
      t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
      m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
      c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
      p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
      d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
      v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
      R = {
        "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
        "Reload Workspace",
      },
      o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
    }
  end
})
