local function show_keymaps()
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new, unlisted buffer

  -- Open a new vertical split and display the buffer
  vim.cmd("vsplit")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile") -- Avoid saving
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe") -- Wipe the buffer when hidden
  vim.api.nvim_buf_set_option(buf, "swapfile", false) -- Disable swap file

  -- Make the buffer modifiable
  vim.api.nvim_buf_set_option(buf, "modifiable", true)

  -- Read the content of the keymaps file
  local keymaps_file = vim.fn.stdpath("config") .. "/lua/keymaps.lua"
  local lines = vim.fn.readfile(keymaps_file)

  -- Insert the content into the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set the filetype to Lua for syntax highlighting
  vim.api.nvim_buf_set_option(buf, "filetype", "lua")

  -- Add a title
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, { "=== Keymaps ===", "" })

  -- Optional enhancements
  vim.api.nvim_win_set_option(win, "cursorline", false) -- Disable cursorline
  vim.api.nvim_buf_set_name(buf, "Keymaps") -- Set a custom buffer name
  vim.api.nvim_win_set_option(win, "number", false) -- Disable line numbers
  vim.api.nvim_win_set_option(win, "relativenumber", false) -- Disable relative numbers
end

return show_keymaps
