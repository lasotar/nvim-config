local keymaps_cmd = require("commands.keymaps_cmd")
local cproj_cmd = require("commands.createCproj")

vim.api.nvim_create_user_command("Keymaps", keymaps_cmd , {})
vim.api.nvim_create_user_command("CreateCProject", function(opts)
  cproj_cmd(opts.args)
end, {
  nargs = 1, -- Require exactly one argument
  desc = "Generate compile_commands.json in the specified project root",
})
