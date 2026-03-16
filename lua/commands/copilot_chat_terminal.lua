local M = {}
local chat_bufnr = nil

M.toggle_chat = function()
  -- Check if buffer exists and is valid
  if chat_bufnr and vim.api.nvim_buf_is_valid(chat_bufnr) then
    -- Find if there's a window showing this buffer
    local winid = vim.fn.bufwinid(chat_bufnr)
    if winid ~= -1 then
      -- If window is visible, hide it
      vim.api.nvim_win_hide(winid)
      return
    else
      -- If window is not visible, open it
      vim.cmd("botright vsplit")
      vim.api.nvim_set_current_buf(chat_bufnr)
    end
  else
    -- Create new buffer and start process
    vim.cmd("botright vnew")
    chat_bufnr = vim.api.nvim_get_current_buf()
    
    -- Set buffer options
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.buflisted = false -- Keep it out of :bnext/:bprev
    
    -- Start gh copilot chat
    vim.fn.termopen("gh copilot")
    
    -- When the process finishes, reset chat_bufnr so we can start a new one if needed
    vim.api.nvim_create_autocmd("TermClose", {
      buffer = chat_bufnr,
      callback = function()
        -- Optional: you might want to keep the buffer to see the history even after exit,
        -- but usually, if 'gh copilot chat' exits, the session is over.
        chat_bufnr = nil
      end,
    })
  end

  -- Set the width to 30% of total columns
  local width = math.floor(vim.o.columns * 0.3)
  vim.api.nvim_win_set_width(0, width)
  
  -- Enter insert mode automatically
  vim.cmd("startinsert")
end

return M
