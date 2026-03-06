require("settings")
require("core.core_load")

local set_keymaps = require("keymaps")
set_keymaps();

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.ino", "*.pde" },
  command = "set filetype=arduino",
})



-- Use arduino-cli's built-in serial monitor

vim.g.arduino_serial_program = "arduino-cli monitor"

require("commands.command_register")

