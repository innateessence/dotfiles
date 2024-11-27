----------------------------------
-- Additional 3rd party plugins --
----------------------------------

-- Additional Plugins
lvim.plugins = {
  -- Theme / colorscheme
  {
    "EdenEast/nightfox.nvim",
    config = function()
      local options = { transparent = lvim.transparent_window, }
      require("nightfox").setup({ { options = options }, })
    end -- use lunarvim's transparency setting for colorscheme
  },

  {
    -- Dedicated Diagnostics preview window
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  {
    -- Markdown Viewer via `glow` (`glow` must be in PATH)
    "npxbr/glow.nvim",
    ft = { "markdown" },
  },

  {
    -- LunarVim friendly Git Diffs
    "sindrets/diffview.nvim",
    event = "BufRead",
  },

  {
    -- Colorize Color Codes
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },

  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}, -- Border characters of the floating window
        default_mappings = true, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true, -- Focus the floating window when opening it.
        dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
        zindex = 1 -- Starting zindex for the stack of floating windows
    }
    end
  },
  -- Rainbow-ify my parans (and brackets, ect..)
  {
    "p00f/nvim-ts-rainbow",
    -- This is toggled on/off using `lvim.builtin.treesitter.rainbow.enable = true`
  },

  -- Show function signature as you type (lsp arguments as you type them.)
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },

  -- Smooth scrolling :)
  -- {
  --   "karb94/neoscroll.nvim",
  --   event = "WinScrolled",
  --   config = function()
  --     local mappings = {}
  --     local slow = '450'
  --     local medium = '150'
  --     local fast = '50'
  --     mappings['<PageUp>'] = { 'scroll', { '-vim.wo.scroll', 'true', fast, [['sine']] } }
  --     mappings['<PageDown>'] = { 'scroll', { 'vim.wo.scroll', 'true', fast, [['sine']] } }
  --     mappings['<C-PageUp>'] = { 'scroll', { '-vim.wo.scroll', 'true', medium, [['sine']] } }
  --     mappings['<C-PageDown>'] = { 'scroll', { 'vim.wo.scroll', 'true', medium, [['sine']] } }
  --     mappings['<C-Up>'] = { 'scroll', { '-vim.wo.scroll', 'true', slow, [['sine']] } }
  --     mappings['<C-Down>'] = { 'scroll', { 'vim.wo.scroll', 'true', slow, [['sine']] } }

  --     require('neoscroll').setup({
  --       -- All these keys will be mapped to their corresponding default scrolling animation
  --       -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
  --       --         '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
  --       mappings = {},               -- Disabled overriding default bindings. Macros are useful sometimes.
  --       hide_cursor = true,          -- Hide cursor while scrolling
  --       stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  --       use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
  --       respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  --       cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  --       easing_function = nil,       -- Default easing function
  --       pre_hook = nil,              -- Function to run before the scrolling animation starts
  --       post_hook = nil,             -- Function to run after the scrolling animation ends
  --     })
  --     require('neoscroll.config').set_mappings(mappings)
  --   end
  -- },

  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },

  -- Git Blame
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = false }
    end,
  },

  -- TODO: and misc related comments highlighter
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
}
