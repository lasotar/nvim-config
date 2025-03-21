require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp" }, -- Install parsers for C and C++
  highlight = { enable = true }, -- Enable syntax highlighting
  indent = { enable = true }, -- Enable indentation
  incremental_selection = { enable = true }, -- Enable incremental selection
  textobjects = { enable = true }, -- Enable text objects
})
