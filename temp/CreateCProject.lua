local function generate_compile_commands(project_root)
  -- Resolve relative paths to absolute paths
  local absolute_root = vim.loop.fs_realpath(project_root) or vim.fn.fnamemodify(project_root, ":p")

  if not absolute_root then
    print("Error: Could not resolve path to absolute: " .. project_root)
    return
  end

  -- Content of compile_commands.json
  local compile_commands = [[
  [
    {
      "directory": "./build",
      "command": "/usr/bin/cc -nostdinc -Wall -Wextra -fsanitize=address,undefined -std=gnu11 -std=gnu99 -o CMakeFiles/testing.dir/test.c.o -c -I/usr/include -I/usr/lib/gcc/x86_64-pc-linux-gnu/14.2.1/include",
      "file": "]] .. absolute_root .. [["
    }
  ]
  ]]

  -- Path to save the compile_commands.json file
  local path = absolute_root .. "/compile_commands.json"

  -- Write the file
  local file = io.open(path, "w")
  if file then
    file:write(compile_commands)
    file:close()
    print("compile_commands.json created at " .. path)
  else
    print("Failed to write compile_commands.json at " .. path)
  end
end

-- Define a Neovim command :CreateCProject <project_root>
vim.api.nvim_create_user_command("CreateCProject", function(opts)
  generate_compile_commands(opts.args)
end, {
  nargs = 1, -- Require exactly one argument
  desc = "Generate compile_commands.json in the specified project root",
})
