return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      clangd = function(_, opts)
        opts.capabilities.offsetEncoding = { "utf-16" }
      end,
    },

    servers = {
      pyright = {
        keys = {
          {
            "<leader>co",
            function()
              require("functions.isort").organize_imports()
            end,
            desc = "Organize Imports (isort)",
          },
        },
      },
    },
  },
}
