# Nvim config
A neovim configuration written completely from scratch - no distributions, no problems

## Plugins
Core plugins as well as the graphical interface (theme, statusline, etc.) are placed in the lua/core directory.
Other plugins are placed in lua/plugins

### Core plugins (do not edit)
- Lazy.nvim (https://github.com/folke/lazy.nvim)
- Treesitter (https://github.com/nvim-treesitter/nvim-treesitter)
- Mason.nvim (https://github.com/williamboman/mason.nvim)

### Graphical plugins
- Default theme: Highly customized Carbonfox theme (https://github.com/EdenEast/nightfox.nvim)
- Statusline: Lualine (https://github.com/nvim-lualine/lualine.nvim)

### Other plugins
- Autocomplete: nvim-cmp (https://github.com/hrsh7th/nvim-cmp)
- Comments: comment.nvim (https://github.com/numToStr/Comment.nvim)
- Autopairs (https://github.com/windwp/nvim-autopairs)
- Neo-tree (https://github.com/nvim-neo-tree/neo-tree.nvim)
- Telescope (https://github.com/nvim-telescope/telescope.nvim)

## Commands
The config has some custom commands, all placed in lua/commands
- ```:CreateCProject <dir>``` - Creates a file providing C/GNU syntax
- ```:Keymaps``` - Opens the file where all keymaps are defined

## Installation
Make sure nvim is installed. Then
```git clone https://github.com/lasotar/nvim-config ~/.config/nvim```

## Extending
- If you want to add your own plugins, edit the lua/plugins/plugin_list.lua file.
- If you want to add your own commands, add the file with the command to lua/commands and register it in the lua/commads/command_register.lua file

## Prerequisites
- A nerd font (for example JetBrains nerd font)
- Ripgrep

## Future
Current TODO list:
- Make comment.nvim keymaps editable            Priority: Low
- Add and configure mini.nvim                   Priority: Medium
- Add C debugger                                Priority: Medium
- Make it suitable for C++                      Priority: Medium
- Make the config work for Angular webdev       Priority: Low

## FAQ
How to change the theme?
- You can edit the theme in lua/core/visual.lua. Just replace the existing one. Then, change the other hexcodes in visual.lua
