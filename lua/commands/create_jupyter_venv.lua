local M = {}

function M.create_venv()
  return function()
    local venv_name = vim.fn.input("Enter venv name (default: .venv): ")
    if venv_name == "" then
      venv_name = ".venv"
    end

    local install_cmd = string.format(
      "python3 -m venv %s && %s/bin/pip install pynvim jupyter_client ipykernel jupytext && %s/bin/python -m ipykernel install --user --name=%s --display-name='Python 3 (%s)'",
      venv_name, venv_name, venv_name, venv_name, venv_name
    )

    print("Creating venv and installing packages (pynvim, jupyter_client, ipykernel, jupytext)...")
    
    vim.fn.jobstart(install_cmd, {
      on_stdout = function(_, data)
        if data then
          for _, line in ipairs(data) do
            if line ~= "" then print(line) end
          end
        end
      end,
      on_stderr = function(_, data)
        if data then
          for _, line in ipairs(data) do
            if line ~= "" then print("Error: " .. line) end
          end
        end
      end,
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          print("Jupyter-compatible venv '" .. venv_name .. "' created and kernel registered successfully.")
        else
          print("Failed to create venv. Exit code: " .. exit_code)
        end
      end,
    })
  end
end

return M
