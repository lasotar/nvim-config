-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "cssls", "omnisharp", "r_language_server", "ts_ls", "hls", "pyright"},
})

-- Enhance capabilities with nvim-cmp for completion (Global config for all servers)
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities()
})

-- pyright setup
vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
        diagnosticSeverityOverrides = {
          reportArgumentType = "none",
        },
      },
    },
  },
  on_init = function(client)
    local venv_path = vim.fn.getcwd() .. "/.venv"
    if vim.fn.isdirectory(venv_path) == 1 then
      client.config.settings.python.pythonPath = venv_path .. "/bin/python"
      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
  end,
})

-- clangd setup
vim.lsp.config("clangd", {
  filetypes = { "c", "cpp", "arduino" },
  cmd = {
    "clangd",
    "--compile-commands-dir=./build",
    "--log=verbose",
    "--background-index",
  },
})

-- omnisharp setup
vim.lsp.config("omnisharp", {
  cmd = { "omnisharp" },
  enable_import_completion = true,
  organize_imports_on_format = true,
  handlers = {
    ["textDocument/definition"] = function(...)
        return require('omnisharp_extended').handler(...)
    end,
  },
})

-- typescript setup
vim.lsp.config("ts_ls", {
  flags = {
    debounce_text_changes = 150,
  },
})

-- angularls setup
vim.lsp.config("angularls", {
  cmd = { "ngserver", "--stdio", "--tsProbeLocations", ".", "--ngProbeLocations", "." },
  root_dir = function(path)
    return vim.fs.root(path, {"angular.json", "package.json", ".git"})
  end,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
})

-- cssls setup
vim.lsp.config("cssls", {
  filetypes = { "css", "scss", "less" },
})

-- r_language_server setup
vim.lsp.config("r_language_server", {
  filetypes = { "r", "rmd" },
})

-- haskell setup
vim.lsp.config("hls", {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
})

-- Enable the servers
vim.lsp.enable({
  "pyright",
  "clangd",
  "omnisharp",
  "ts_ls",
  "angularls",
  "cssls",
  "r_language_server",
  "hls"
})
