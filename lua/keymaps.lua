local function set_keymaps()
  -- General mappings
  vim.g.mapleader = " "

  -- LSP mappings
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code" })

  -- nvim-cmp mappings
  local cmp = require("cmp")
  local mappings = {
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-l>"] = cmp.mapping.confirm({select = true}),
  }

  for key, mapping in pairs(mappings) do
    vim.keymap.set("i", key, mapping)
  end

  -- Comment keymaps
  -- gc (normal): toggle linewise
  -- no need for anything else rly

  -- Bufferline
  vim.keymap.set("n", "<leader><Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
  vim.keymap.set("n", "<leader>d<Tab>", ":bd<CR>", { desc = "Close current buffer", silent = true })

  -- Neo-tree
  vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })

  -- Keybindings for Telescope
  local telescope = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Help tags" })
end

return set_keymaps
