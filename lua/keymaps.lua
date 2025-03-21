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

  -- Comment keymaps (from mini.nvim)
  -- gc (normal): toggle linewise
  -- no need for anything else rly

  -- Bufferline
  vim.keymap.set("n", "<leader><Tab>", ":bnext<CR>", { desc = "Next buffer", silent = true })
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

-- MINI GUIDE: THE AWESOME KEYMAPS
-- Neovim Keymap Guide: mini.ai, mini.surround, and mini.operators
--
-- This guide provides a quick reference for the key combinations and their functionality for the mini.nvim plugins: mini.ai, mini.surround, and mini.operators.
-- 1. mini.ai Keymaps
--
-- mini.ai provides text objects for operating on chunks of text.
--             
--             Keymap	Description
--             di(	Delete inside parentheses
--             da"	Delete around quotes
--             ci[	Change inside square brackets
--             ca{	Change around curly braces
--             yi<	Yank inside angle brackets
--             `ya``	Yank around backticks
--
-- 2. mini.surround Keymaps
--
-- mini.surround provides surrounding functionality for adding, deleting, or replacing surrounding characters.
--
--             Keymap	Description
--             sa + motion + char	Add surrounding (e.g., saiw" surrounds word with ")
--             sd + char	Delete surrounding (e.g., sd" deletes surrounding ")
--             sr + old_char + new_char	Replace surrounding (e.g., sr"' replaces " with ')
--             sa (visual mode) + char	Add surrounding to selected text
--             3. mini.operators Keymaps
--
-- mini.operators provides custom operators for evaluating expressions, replacing text, and sorting lines.
--
--             Keymap	Description
--             g=	Evaluate expression
--             gr	Replace text
--             gs	Sort lines
--
-- 4. Usage Examples
-- mini.ai
--
--     Delete Inside Parentheses:
--
--         Place cursor inside (hello world).
--
--         Press di( to delete the text inside: ().
--
--     Change Around Quotes:
--
--         Place cursor inside "hello world".
--
--         Press ca" to change the text around the quotes: "".
--
--     Yank Inside Brackets:
--
--         Place cursor inside [hello world].
--
--         Press yi[ to yank the text inside: [hello world].
--
-- mini.surround
--
--     Add Surrounding Quotes:
--
--         Place cursor on a word, e.g., hello.
--
--         Press saiw" to surround the word with double quotes: "hello".
--
--     Delete Surrounding Brackets:
--
--         Place cursor inside [hello].
--
--         Press sd[ to delete the brackets: hello.
--
--     Replace Surrounding Quotes:
--
--         Place cursor inside "hello".
--
--         Press sr"' to replace double quotes with single quotes: 'hello'.
--
-- mini.operators
--
--     Evaluate Expression:
--
--         Place cursor on a line with an expression, e.g., 2 + 2.
--
--         Press g= to evaluate the expression: 4.
--
--     Replace Text:
--
--         Place cursor on a word, e.g., hello.
--
--         Press gr to replace the word with new text.
--
--     Sort Lines:
--
--         Select multiple lines in visual mode.
--
--         Press gs to sort the selected lines alphabetically.
--
--5. Summary of Keymaps
--
--             mini.ai
--
--             Keymap	Description
--             di(	Delete inside parentheses
--             da"	Delete around quotes
--             ci[	Change inside square brackets
--             ca{	Change around curly braces
--             yi<	Yank inside angle brackets
--             `ya``	Yank around backticks
--
--             mini.surround
--             
--             Keymap	Description
--             sa + motion + char	Add surrounding (e.g., saiw")
--             sd + char	Delete surrounding (e.g., sd")
--             sr + old_char + new_char	Replace surrounding (e.g., sr"')
--             sa (visual mode) + char	Add surrounding to selected text
--
--             mini.operators
--
--             Keymap	Description
--             g=	Evaluate expression
--             gr	Replace text
--             gs	Sort lines
