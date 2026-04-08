-- Workaround for tree-sitter CLI 0.25+ compatibility
-- The latest CLI removed the --no-bindings flag which nvim-treesitter uses by default.
local ok_install, ts_install = pcall(require, "nvim-treesitter.install")
if ok_install then
  ts_install.ts_generate_args = { "generate" }
  ts_install.prefer_git = true
end

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp", "lua", "typescript", "haskell", "css", "r", "c_sharp", "markdown", "markdown_inline", "html", "latex", "yaml" }, -- Install parsers for C, C++, Lua, TypeScript, Haskell, CSS, R, C#, and markdown/web related languages
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
