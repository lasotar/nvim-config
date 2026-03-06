require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp", "lua", "typescript", "haskell", "css", "r", "c_sharp" }, -- Install parsers for C, C++, Lua, TypeScript, Haskell, CSS, R, and C#
  highlight = {
    enable = true, -- Enable syntax highlighting
    additional_vim_regex_highlighting = false, -- Disable legacy regex highlighting
  },
  indent = { enable = true }, -- Enable indentation
  incremental_selection = { enable = true }, -- Enable incremental selection
  textobjects = { enable = true }, -- Enable text objects
  parser_install_dir = nil, -- Use default parser directory
  autotag = {
    enable = true,
  },
  filetype_to_parsername = {
    arduino = "cpp",
  },
})
