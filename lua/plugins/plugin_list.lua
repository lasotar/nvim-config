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
  }
}
