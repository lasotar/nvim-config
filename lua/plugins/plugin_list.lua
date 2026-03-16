return
{
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
          vim.cmd([[highlight NeoTreeNormal guibg=#0b0d13]]) -- Set background for Neo-tree
          vim.cmd([[highlight NeoTreeDirectory guibg=#0b0d13]]) -- Set background for Neo-tree directories
          vim.cmd([[highlight NeoTreeFile guibg=#0b0d13]])
      end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim", -- Required dependency for telescope
        },
        config = function()
          -- Basic Telescope setup
          require("telescope").setup({
            -- You can add custom configurations here
            defaults = {
              mappings = {
                i = {
                  -- Custom keybindings for insert mode
                  ["<C-j>"] = require("telescope.actions").move_selection_next,
                  ["<C-k>"] = require("telescope.actions").move_selection_previous,
                },
              },
            },
          })

      end,
    },
    -- Colorizer
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = { -- set to setup table
       },
    },
   {
      "echasnovski/mini.nvim",
      config = function()
        require('mini.ai').setup({})
        require('mini.comment').setup({})
        require('mini.surround').setup({})
        require('mini.pairs').setup({})
        -- Add more mini.nvim modules as needed
      end,
    },
    {
        "https://github.com/lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    -- AI code completion & Chat
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = {
            enabled = true,
            auto_trigger = true,
            hide_during_completion = false,
            debounce = 75,
            keymap = {
              accept = false, -- Handled in keymaps.lua
              accept_word = false,
              accept_line = false,
              next = false,
              prev = false,
              dismiss = false,
            },
          },
          panel = { enabled = false },
        })
      end,
    },
    -- Find and Replace
    {
        "nvim-pack/nvim-spectre"
    },
    -- Which-key
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      config = function()
        require("plugins.which-key")
      end,
    },
    -- C# goto definition support
    {
      "Hoffs/omnisharp-extended-lsp.nvim",
      dependencies = { "neovim/nvim-lspconfig" },
    },
    -- LaTeX
    {
      "lervag/vimtex",
      lazy = false,
      init = function()
        vim.g.vimtex_view_method = "zathura" -- or skim, okular, etc.
        vim.g.vimtex_compiler_method = "latexmk"
      end,
    },
    -- Image support (required for Molten images)
    {
      "3rd/image.nvim",
      opts = {
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki", "python" }, -- Added python for Jupytext
          },
        },
        max_width = 100,
        max_height = 25,
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      },
    },
    -- Molten (Jupyter in Neovim)
    {
      'benlubas/molten-nvim',
      version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
      dependencies = { '3rd/image.nvim' },
      build = ':UpdateRemotePlugins',
      lazy = false,
      init = function()
        -- these are examples, not defaults. Please see the readme
        vim.g.molten_image_provider = 'image.nvim'
        vim.g.molten_output_win_max_height = 20
      end,
      config = function()
        -- Paste the notebook command code here!
        -- Template for a minimal, valid Python notebook
        local default_notebook = [[
        {
          "cells": [
           {
            "cell_type": "markdown",
            "metadata": {},
            "source": [
              ""
            ]
           }, 
	   {
	      "cell_type": "code",
	      "metadata": {},
	      "source": [
		"print('Hello from Molten Python cell!')"
	      ],
	      "outputs": [],
	      "execution_count": null
	    }
          ],
          "metadata": {
           "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
           },
           "language_info": {
            "codemirror_mode": {
              "name": "ipython"
            },
            "file_extension": ".py",
            "mimetype": "text/x-python",
            "name": "python",
            "nbconvert_exporter": "python",
            "pygments_lexer": "ipython3"
           }
          },
          "nbformat": 4,
          "nbformat_minor": 5
        }
      ]]

        local function new_notebook(filename)
          local path = filename .. '.ipynb'
          local file = io.open(path, 'w')
          if file then
            file:write(default_notebook)
            file:close()
            vim.cmd('edit ' .. path)
          else
            print 'Error: Could not open new notebook file for writing.'
          end
        end

        vim.api.nvim_create_user_command('NewNotebook', function(opts)
          new_notebook(opts.args)
        end, {
          nargs = 1,
          complete = 'file',
        })
      end,
    },
    -- Jupytext (Notebook as scripts)
    {
      "goerz/jupytext.vim",
      lazy = false,
      init = function()
        vim.g.jupytext_fmt = 'py:percent'
        vim.g.jupytext_enable_py = 1
      end,
    },
    -- Render markdown in Neovim (for Jupytext/Notebooks)
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        opts = {
            file_types = { 'markdown', 'python' }, -- Enable for python files (Jupytext)
            anti_conceal = { enabled = true },
        },
    },
    -- Improved rendering for Jupytext
    {
        'cmorales95/jupytext-render.nvim',
        dependencies = { 'MeanderingProgrammer/render-markdown.nvim' },
        opts = {
            -- Keymap for toggling is <leader>mM by default, but we'll use <leader>tm in keymaps.lua
        },
        config = true,
    },
    -- Notebook Navigator (better cell navigation)
    {
      "GCBallesteros/NotebookNavigator.nvim",
      dependencies = {
        "echasnovski/mini.comment",
        "hkupty/iron.nvim", -- Optional REPL support
        "nvimtools/hydra.nvim", -- Use the maintained version
      },
      config = function()
        local nn = require("notebook-navigator")
        nn.setup({
          repl_provider = "molten",
        })
      end,
    },
}
