require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt", "vim" },
    disable_in_macro = true,
    disable_in_visualblock = true,
    enable_check_bracket_line = true,
    ignored_next_char = "[%w%.]",
    enable_afterquote = true,
    enable_moveright = true,
    enable_bracket_in_quote = true,
    map_cr = true,
})
