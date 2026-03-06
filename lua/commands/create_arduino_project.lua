local M = {}

function M.create_compile_commands()
  return function()
    local fqbn = vim.fn.input("Enter the FQBN of your board: ")
    if fqbn == "" then
      print("FQBN cannot be empty.")
      return
    end

    local cmd = "arduino-cli compile --fqbn " .. fqbn .. " --build-path ./build --only-compilation-database"
    local job_id = vim.fn.jobstart(cmd, {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          print("compile_commands.json created successfully.")
        else
          print("Error creating compile_commands.json. Exit code: " .. exit_code)
        end
      end,
    })
  end
end

return M
