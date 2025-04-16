return
{
    -- Neo-tree
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x", -- Use the stable v3.x branch
      dependencies = {
        "nvim-lua/plenary.nvim", -- Required for neo-tree
        "nvim-tree/nvim-web-devicons", -- Optional, for file icons
        "MunifTanjim/nui.nvim", -- Required for UI components
      },
      config = function()
        require("plugins.neo-tree")
      end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim", -- Required dependency for telescope
        },
        config = function()
          -- Basic Telescope setup
          require("telescope").setup({
            -- You can add custom configurations here
            defaults = {
              mappings = {
                i = {
                  -- Custom keybindings for insert mode
                  ["<C-j>"] = require("telescope.actions").move_selection_next,
                  ["<C-k>"] = require("telescope.actions").move_selection_previous,
                },
              },
            },
          })

      end,
    },
    -- Colorizer
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = { -- set to setup table
       },
    },
   {
      "echasnovski/mini.nvim",
      config = function()
        require('mini.ai').setup({})
        require('mini.comment').setup({})
        require('mini.surround').setup({})
        require('mini.pairs').setup({})
        -- Add more mini.nvim modules as needed
      end,
    },
    {
        "https://github.com/lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    -- AI code completion
    {
      "monkoose/neocodeium",
      event = "VeryLazy",
      config = function()
        local neocodeium = require("neocodeium")
        neocodeium.setup()
      end,
    },
    -- Based
    {
       "m4xshen/hardtime.nvim",
       dependencies = { "MunifTanjim/nui.nvim" },
       opts = {}
    },

    -- Tutorial motions
    {
    "tris203/precognition.nvim",
    --event = "VeryLazy",
    opts = {
    -- startVisible = true,
    -- showBlankVirtLine = true,
    -- highlightColor = { link = "Comment" },
    -- hints = {
    --      Caret = { text = "^", prio = 2 },
    --      Dollar = { text = "$", prio = 1 },
    --      MatchingPair = { text = "%", prio = 5 },
    --      Zero = { text = "0", prio = 1 },
    --      w = { text = "w", prio = 10 },
    --      b = { text = "b", prio = 9 },
    --      e = { text = "e", prio = 8 },
    --      W = { text = "W", prio = 7 },
    --      B = { text = "B", prio = 6 },
    --      E = { text = "E", prio = 5 },
    -- },
    -- gutterHints = {
    --     G = { text = "G", prio = 10 },
    --     gg = { text = "gg", prio = 9 },
    --     PrevParagraph = { text = "{", prio = 8 },
    --     NextParagraph = { text = "}", prio = 8 },
    -- },
    -- disabled_fts = {
    --     "startify",
    -- },
    },
}
}
