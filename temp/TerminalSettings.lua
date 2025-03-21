-- Define a custom command to open kitty.conf in a horizontal split
vim.api.nvim_create_user_command('KittyConfig', function()
    vim.cmd('split ~/.config/kitty/kitty.conf')
end, {})

-- Define an autocommand to reload kitty when kitty.conf is saved
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '~/.config/kitty/kitty.conf',
    callback = function()
        -- Save the current session state
        vim.cmd('mksession! ~/.cache/nvim/session.vim')

        -- Reload kitty
        vim.fn.system('kitty @ set-colors --all --configured ~/.config/kitty/kitty.conf')

        -- Restore the nvim session
        vim.cmd('source ~/.cache/nvim/session.vim')
    end,
})
