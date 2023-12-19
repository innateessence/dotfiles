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
    -- Show current function at top of screen when function does not fit in screen
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
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
    -- Preview LSP GoTo
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120,              -- Width of the floating window
        height = 25,              -- Height of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false,            -- Print debug information
        opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil      -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
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
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      local mappings = {}
      local slow = '450'
      local medium = '150'
      local fast = '50'
      mappings['<PageUp>'] = { 'scroll', { '-vim.wo.scroll', 'true', fast, [['sine']] } }
      mappings['<PageDown>'] = { 'scroll', { 'vim.wo.scroll', 'true', fast, [['sine']] } }
      mappings['<C-PageUp>'] = { 'scroll', { '-vim.wo.scroll', 'true', medium, [['sine']] } }
      mappings['<C-PageDown>'] = { 'scroll', { 'vim.wo.scroll', 'true', medium, [['sine']] } }
      mappings['<C-Up>'] = { 'scroll', { '-vim.wo.scroll', 'true', slow, [['sine']] } }
      mappings['<C-Down>'] = { 'scroll', { 'vim.wo.scroll', 'true', slow, [['sine']] } }

      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
        --         '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        mappings = {},               -- Disabled overriding default bindings. Macros are useful sometimes.
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
      require('neoscroll.config').set_mappings(mappings)
    end
  },

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
