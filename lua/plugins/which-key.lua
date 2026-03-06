local wk = require("which-key")

wk.add({
  { "<leader>f", group = "Find/Telescope/Format" },
  { "<leader>g", group = "Go To/LSP" },
  { "<leader>r", group = "Molten Evaluation" },
  { "<leader>o", group = "Molten Output/Kernel" },
  { "<leader>m", group = "Molten Init/Setup" },
  { "<leader>i", group = "Molten Control" },
  { "<leader>t", group = "Toggle" },
  { "<leader>d", group = "Close Buffer" },
  { "]", group = "Diagnostics/Navigation" },
})

wk.setup({
  -- You can add your configuration here if you want to override defaults
  preset = "modern", -- modern, classic, helix
})
