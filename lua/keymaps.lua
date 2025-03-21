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

  -- TODO: add bufferline keymaps

  -- Neo-tree
  vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })
  -- Focus on neo-tree
  vim.keymap.set("n", "<leader>E", "<Cmd>Neotree focus<CR>", { desc = "Focus NeoTree" })
end

return set_keymaps
