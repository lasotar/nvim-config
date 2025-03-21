return {
  -- Theme (carbonfox)
  {
    "EdenEast/nightfox.nvim",
    lazy = false, -- Load immediately
    priority = 1000, -- Load before other plugins
    config = function()
      -- Apply custom highlights after the colorscheme and Tree-sitter are loaded
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Custom highlights
          vim.api.nvim_set_hl(0, "Comment", { fg = "#D2B48C", italic = false }) -- Brighter comments (beige)
          vim.api.nvim_set_hl(0, "Normal", { bg = "#0a0a0a" }) -- Darker background (black)
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0a0a0a" }) -- Darker background for floating windows
          vim.api.nvim_set_hl(0, "CursorLine", { bg = "#161616" }) -- Darker highlighted line
          vim.api.nvim_set_hl(0, "Cursor", { fg = "#EEEEEE", bg = "#FF0000" }) -- Custom cursor color
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "#0a0a0a" }) -- Match inactive window background
          vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#333333", bg = "#0a0a0a" }) -- Customize window separator
          vim.api.nvim_set_hl(0, "@property", { fg = "#5e7aca" }) -- Dark blue struct fields
        end,
      })

      vim.cmd([[colorscheme carbonfox]])
    end,
  },
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: for icons
    config = function()
      require("lualine").setup({
        options = {
          theme = "carbonfox", -- Match your theme (or use "auto" for automatic theme detection)
          icons_enabled = true, -- Enable icons (requires a patched font or nvim-web-devicons)
          component_separators = { left = "", right = "" }, -- Separators between components
          section_separators = { left = "", right = "" }, -- Separators between sections
        },
        sections = {
          lualine_a = { "mode" }, -- Left section (mode)
          lualine_b = { "branch", "diff", "diagnostics" }, -- Left-middle section (git branch, diff, diagnostics)
          lualine_c = { "filename" }, -- Middle section (file name)
          lualine_x = { "filetype" }, -- Right-middle section (file type)
          lualine_y = { "progress" }, -- Right section (line and column number)
          lualine_z = { "location" }, -- Far-right section (cursor location)
        },
        inactive_sections = {
          lualine_a = {}, -- Inactive left section
          lualine_b = {}, -- Inactive left-middle section
          lualine_c = { "filename" }, -- Inactive middle section (file name)
          lualine_x = { "location" }, -- Inactive right section (cursor location)
          lualine_y = {}, -- Inactive right-middle section
          lualine_z = {}, -- Inactive far-right section
        },
      })
    end,
  },
}
