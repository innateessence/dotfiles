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
              local isort = require("functions.isort")
              isort.call()
            end,
            desc = "Organize Imports (isort)",
          },
        },
      },
    },
  },
}
