require("neo-tree").setup({
  close_if_last_window = true, -- Close neo-tree if it's the last window
  popup_border_style = "rounded", -- Border style for popups
  enable_git_status = true, -- Show git status in the file tree
  enable_diagnostics = true, -- Show diagnostics in the file tree
  default_component_configs = {
    icon = {
      folder_closed = "", -- Icon for closed folders
      folder_open = "", -- Icon for open folders
      folder_empty = "", -- Icon for empty folders
      default = "", -- Default icon for files
    },
    git_status = {
      symbols = {
        added = "", -- Symbol for added files
        modified = "", -- Symbol for modified files
        deleted = "", -- Symbol for deleted files
        renamed = "➜", -- Symbol for renamed files
        untracked = "", -- Symbol for untracked files
        ignored = "", -- Symbol for ignored files
        unstaged = "", -- Symbol for unstaged changes
        staged = "", -- Symbol for staged changes
        conflict = "", -- Symbol for merge conflicts
      },
    },
  },
  window = {
    position = "left", -- Position of the neo-tree window (left, right, float)
    width = 30, -- Width of the neo-tree window
    mappings = {
      ["<Tab>"] = "toggle_node", -- Expand/collapse folders
      ["<CR>"] = "open", -- Open files or folders
      ["<leader>e"] = "focus", -- Focus on neo-tree
    },
  },
  filesystem = {
    filtered_items = {
      visible = true, -- Show hidden files by default
      hide_dotfiles = false, -- Show dotfiles
      hide_gitignored = false, -- Show gitignored files
    },
    follow_current_file = true, -- Follow the current file in the tree
    hijack_netrw_behavior = "open_current", -- Replace netrw with neo-tree
  },
})
