-- Declared at core/visual

require("bufferline").setup({
  options = {
    mode = "buffers", -- Set to "buffers" to show buffers, or "tabs" for tabs
    numbers = "none", -- Show buffer numbers (options: "none", "ordinal", "buffer_id")
    diagnostics = "nvim_lsp", -- Show LSP diagnostics in the bufferline
    offsets = {
      {
        filetype = "NvimTree", -- Adjust for file explorers like NvimTree
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
    show_buffer_close_icons = true, -- Show close icons for buffers
    show_close_icon = true, -- Show close icon for the bufferline itself
    separator_style = "slant", -- Style of separators (options: "slant", "thick", "thin", "padded_slant")
    color_icons = true, -- Color icons based on filetype
    hover = {
      enabled = true, -- Enable hover highlights
      delay = 200, -- Delay in milliseconds
      reveal = { "close" }, -- Reveal actions on hover
    },
  },
  highlights = {
    buffer_selected = {
      italic = false, -- Disable italics for the selected buffer
    },
    numbers_selected = {
      italic = false, -- Disable italics for line numbers in the selected buffer
    },
    diagnostic_selected = {
      italic = false, -- Disable italics for diagnostics in the selected buffer
    },
    duplicate_selected = {
      italic = false, -- Disable italics for duplicate selected buffers
    },
    duplicate_visible = {
      italic = false, -- Disable italics for duplicate visible buffers
    },
    duplicate = {
      italic = false, -- Disable italics for duplicate buffers
    },
  },
})
