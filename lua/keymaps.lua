local function set_keymaps()
  -- General mappings
  vim.g.mapleader = " "
  vim.keymap.set("n", "<C-d>", "<C-d>zz")
  vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Centers screen on scroll

  -- LSP mappings
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Show documentation" })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
  vim.keymap.set("n", "<M-CR>", vim.lsp.buf.code_action, { desc = "Code actions" })
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code" })

  -- nvim-cmp mappings are defined in lua/core/languages/autocomplete.lua

  -- Comment keymaps (from mini.nvim)
  -- gc (normal): toggle linewise
  -- no need for anything else rly

  -- Diagnostics
  vim.keymap.set("n", "]]", vim.diagnostic.open_float, { desc = "Open diagnostics" })
  vim.keymap.set("n", "]n", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
  vim.keymap.set("n", "]p", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

  -- Bufferline
  vim.keymap.set("n", "<leader><Tab>", ":bnext<CR>", { desc = "Next buffer", silent = true })
  vim.keymap.set("n", "<leader>d<Tab>", ":bd<CR>", { desc = "Close current buffer", silent = true })

  for i = 1, 9 do 
    vim.keymap.set("n", "<leader>" .. i .. "<Tab>", function()
      local bufs = vim.fn.getbufinfo({ buflisted = 1 })
      local target = bufs[i]
      if target then
        vim.api.nvim_set_current_buf(target.bufnr)
      end
    end, { desc = "Go to buffer " .. i, silent = true })
  end

  -- Neo-tree
  vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle NeoTree", silent = true })

  -- Keybindings for Telescope
  local telescope = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Help tags" })

  -- AI code completion & Chat
  -- These mappings handle GitHub Copilot "Ghost Text" suggestions.
  -- <C-Space> is hybrid: it accepts a suggestion if visible, otherwise it opens the cmp menu.
  vim.keymap.set("i", "<C-Space>", function()
    if require("copilot.suggestion").is_visible() then
      require("copilot.suggestion").accept()
    else
      require("cmp").complete()
    end
  end, { desc = "Copilot - Accept Suggestion or Trigger Cmp" })

  -- Granular ghost text controls (NeoCodeium style)
  vim.keymap.set("i", "<M-w>", function() require("copilot.suggestion").accept_word() end, { desc = "Copilot - Accept word" })
  vim.keymap.set("i", "<M-l>", function() require("copilot.suggestion").accept_line() end, { desc = "Copilot - Accept line" })
  vim.keymap.set("i", "<M-]>", function() require("copilot.suggestion").next() end, { desc = "Copilot - Next suggestion" })
  vim.keymap.set("i", "<M-[>", function() require("copilot.suggestion").prev() end, { desc = "Copilot - Previous suggestion" })
  vim.keymap.set("i", "<C-]>", function() require("copilot.suggestion").dismiss() end, { desc = "Copilot - Dismiss suggestion" })

  -- Chat Window Management
  local chat = require("CopilotChat")
  vim.keymap.set("n", "<leader>cc", function() chat.toggle() end, { desc = "CopilotChat - Toggle", silent = true })
  vim.keymap.set("v", "<leader>cc", function() chat.toggle() end, { desc = "CopilotChat - Toggle", silent = true })

  -- Function to insert text into the CopilotChat buffer
  local function insert_to_chat(text)
    chat.open() -- Ensure chat is open (it won't steal focus if already open)
    -- Wait for the buffer to be ready
    vim.defer_fn(function()
      local bufnr = chat.chat and chat.chat.bufnr or nil
      if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local last_line_idx = #lines - 1
        local last_line_content = lines[#lines]
        local last_col = #last_line_content

        -- Add a space if the line isn't empty and doesn't end with one
        if last_col > 0 and last_line_content:sub(-1) ~= " " then
          text = " " .. text
        end
        text = text .. " "

        -- Insert the text at the very end of the buffer
        vim.api.nvim_buf_set_text(bufnr, last_line_idx, last_col, last_line_idx, last_col, { text })
        
        -- If the chat window is visible, move its cursor to the end so you see the update
        local win = chat.chat.winnr
        if win and vim.api.nvim_win_is_valid(win) then
          local new_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          vim.api.nvim_win_set_cursor(win, { #new_lines, #new_lines[#new_lines] })
        end
      end
    end, 50)
  end

  -- Context Management (The "Add" Menu)
  -- <leader>ca: Add a single file using a Telescope search
  vim.keymap.set("n", "<leader>ca", function()
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    require("telescope.builtin").find_files({
      prompt_title = "Add File to Copilot Chat",
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          insert_to_chat("#file:" .. selection.path)
        end)
        return true
      end,
    })
  end, { desc = "CopilotChat - Add file to context" })

  -- <leader>cb: Add current buffer to chat
  vim.keymap.set("n", "<leader>cb", function()
    insert_to_chat("#buffer")
  end, { desc = "CopilotChat - Add current buffer to context" })

  -- Quick Chat Commands (Slash Commands)
  vim.keymap.set("n", "<leader>ce", function() chat.ask("/explain #buffer") end, { desc = "CopilotChat - Explain code" })
  vim.keymap.set("n", "<leader>cf", function() chat.ask("/fix #selection") end, { desc = "CopilotChat - Fix code" })
  vim.keymap.set("v", "<leader>cf", function() chat.ask("/fix #selection") end, { desc = "CopilotChat - Fix selection" })
  vim.keymap.set("n", "<leader>ct", function() chat.ask("/tests #buffer") end, { desc = "CopilotChat - Generate tests" })
  vim.keymap.set("n", "<leader>cr", function() chat.ask("/review #buffer") end, { desc = "CopilotChat - Review code" })
  -- Persistence for AI model selection
  local model_cache_file = vim.fn.stdpath("data") .. "/copilot_chat_model"
  
  local function save_model(model_name)
    local f = io.open(model_cache_file, "w")
    if f then
      f:write(model_name)
      f:close()
    end
  end

  local function load_last_model()
    local f = io.open(model_cache_file, "r")
    if f then
      local model = f:read("*all")
      f:close()
      if model and model ~= "" then
        -- Apply the saved model to the current session
        chat.setup({ model = model })
      end
    end
  end

  -- Load the model on startup
  vim.schedule(load_last_model)

  -- Improved Model Picker that saves selection
  vim.keymap.set("n", "<leader>cm", function()
    -- Use the built-in model picker
    vim.cmd("CopilotChatModels")
    
    -- After picking (using vim.ui.select usually), the plugin updates its config.
    -- We wait a moment and then save the newly selected model.
    vim.defer_fn(function()
      local current_model = chat.config.model
      if current_model then
        save_model(current_model)
        vim.notify("Copilot Model Persisted: " .. current_model)
      end
    end, 5000) -- Wait for user to actually pick
  end, { desc = "CopilotChat - Select & Persist Model" })

  -- Copilot Panel/Toggle
  vim.keymap.set("n", "<leader>tc", ":Copilot toggle<CR>", { desc = "Toggle Copilot AI" })


  -- Find and Replace with Spectre
  vim.keymap.set("n", "<leader>fr", ":Spectre<CR>", { desc = "Find and Replace", silent = true })

  -- Molten (Jupyter in Neovim)
  vim.keymap.set("n", "<leader>mi", function()
    local kernel = vim.fn.input("Kernel name (default: python3): ")
    if kernel == "" then kernel = "python3" end
    vim.cmd("MoltenInit " .. kernel)
  end, { desc = "Initialize Molten with Kernel" })
  vim.keymap.set("n", "<leader>mj", ":CreateJupyterVenv<CR>", { silent = true, desc = "Create Jupyter Venv" })
  vim.keymap.set("n", "<leader>ir", ":MoltenRestart<CR>", { silent = true, desc = "Restart Molten" })
  vim.keymap.set("n", "<leader>rd", ":MoltenDelete<CR>", { silent = true, desc = "Molten Delete Cell" })
  vim.keymap.set("n", "<leader>re", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "Evaluate Operator" })
  vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Evaluate Line" })
  vim.keymap.set("n", "<leader>rc", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Re-evaluate Cell" })
  vim.keymap.set("v", "<leader>rv", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "Evaluate Visual Selection" })
  vim.keymap.set("n", "<leader>os", ":MoltenShowOutput<CR>", { silent = true, desc = "Show Output" })
  vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { silent = true, desc = "Hide Output" })
  vim.keymap.set("n", "<leader>oi", ":MoltenInterrupt<CR>", { silent = true, desc = "Interrupt Kernel" })

  -- Notebook Navigator
  local nn = require("notebook-navigator")
  vim.keymap.set("n", "]h", function() nn.move_cell("d") end, { desc = "Next cell" })
  vim.keymap.set("n", "[h", function() nn.move_cell("u") end, { desc = "Previous cell" })
  vim.keymap.set("n", "<leader>X", function() nn.run_cell() end, { desc = "Run cell" })
  vim.keymap.set("n", "<leader>x", function() nn.run_and_move() end, { desc = "Run cell and move" })
  vim.keymap.set("n", "<leader>ma", function() nn.add_cell_after() end, { desc = "Add Code cell after" })
  vim.keymap.set("n", "<leader>mb", function() nn.add_cell_before() end, { desc = "Add Code cell before" })
  vim.keymap.set("n", "<leader>mm", function()
    vim.cmd("normal! o# %% [markdown]\n")
    vim.cmd("startinsert")
  end, { desc = "Add Markdown cell after" })
  vim.keymap.set("n", "<leader>mM", function()
    vim.cmd("normal! O# %% [markdown]\n")
    vim.cmd("startinsert")
  end, { desc = "Add Markdown cell before" })
  vim.keymap.set("n", "<leader>md", function() 
    vim.cmd("MoltenDelete") -- Clear output
    -- Delete the text of the cell (uses NotebookNavigator internal logic if available, or simple delete)
    local ok_delete, _ = pcall(nn.split_cell) -- This is a trick to delete if we are in one
    vim.cmd("normal! dip") -- Delete inner paragraph (usually the cell content)
  end, { desc = "Delete cell content and output" })

  -- Manual Hydra definition
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      local ok_nn, nn_hydra = pcall(require, "notebook-navigator")
      local ok_hydra, Hydra = pcall(require, "hydra")
      if ok_nn and ok_hydra then
        Hydra({
          name = "Notebook",
          mode = "n",
          body = "<leader>nh",
          config = {
            color = "amaranth", -- amaranth correctly overwrites keys unlike red
            invoke_on_body = true,
            hint = {
              border = "rounded",
              position = "bottom",
            },
          },
          hint = " [j/k]: Move  [x]: Run  [a/b]: Code  [m/M]: Markdown  [d]: Delete  [c]: Comment  [q/Esc]: Exit ",
          heads = {
            { "j", function() nn_hydra.move_cell("d") end },
            { "k", function() nn_hydra.move_cell("u") end },
            { "x", ":MoltenReevaluateCell<CR>", { silent = true } },
            { "X", ":MoltenEvaluateOperator<CR>", { silent = true } },
            { "a", function() nn_hydra.add_cell_after() end },
            { "b", function() nn_hydra.add_cell_before() end },
            { "m", function()
              vim.cmd("normal! o# %% [markdown]\n")
              vim.cmd("startinsert")
            end },
            { "M", function()
              vim.cmd("normal! O# %% [markdown]\n")
              vim.cmd("startinsert")
            end },
            { "d", function()
              vim.cmd("MoltenDelete")
              vim.cmd("normal! dip") 
            end, { silent = true } },
            { "c", function() nn_hydra.comment_cell() end },
            { "q", nil, { exit = true, nowait = true } },
            { "<Esc>", nil, { exit = true, nowait = true } },
          },
        })
      end
    end,
  })

  -- Toggle Notebook/Markdown Rendering
  vim.keymap.set("n", "<leader>tm", function()
    require("jupytext-render").toggle()
    require("render-markdown").toggle()
  end, { desc = "Toggle Notebook Rendering", silent = true })
end

  -- LaTeX
  -- \ll : compile
  -- \lv : view
  -- \lr : run

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
