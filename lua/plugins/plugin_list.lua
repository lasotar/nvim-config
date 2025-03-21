return
{
    -- Auto-closing pairs
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
          require("plugins.autopairs")
      end,
    },

    -- Commenting
    {
      "numToStr/Comment.nvim",
      event = "VeryLazy", -- Load the plugin lazily
      config = function()
        require("Comment").setup({
          mappings = {
            basic = false,
            extra = false,
          },
        })
      end,
    },
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
    -- Bufferline
    {
        "akinsho/bufferline.nvim",
        version = "v3.*", -- Use the latest stable version
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional dependency for icons
        config = function()
          require("plugins.bufferline")
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
}
