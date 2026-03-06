local keymaps_cmd = require("commands.keymaps_cmd")
local arduino_proj_cmd = require("commands.create_arduino_project")
local jupyter_venv_cmd = require("commands.create_jupyter_venv")

vim.api.nvim_create_user_command("Keymaps", keymaps_cmd , {})

vim.api.nvim_create_user_command("CreateArduinoProject", arduino_proj_cmd.create_compile_commands(), {})

vim.api.nvim_create_user_command("CreateJupyterVenv", jupyter_venv_cmd.create_venv(), {})

