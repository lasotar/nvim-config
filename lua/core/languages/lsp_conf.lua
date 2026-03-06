-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "cssls", "omnisharp", "r_language_server", "ts_ls", "hls", "pyright"},
})

-- Common LSP on_attach function (customize as needed)
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  -- You can place your keymaps and other setups here
  -- Example: disable signatureHelp for clangd like in your config
  -- if client.name == "clangd" then
  --   client.server_capabilities.signatureHelpProvider = false
  -- end
end

-- Enhance capabilities with nvim-cmp for completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP setup
local lspconfig = require("lspconfig")

-- pyright setup
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
        diagnosticSeverityOverrides = {
          reportArgumentType = "none", -- This will stop the "float is not dtype" error
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
lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "c", "cpp", "arduino" },
  cmd = {
    "clangd",
    "--compile-commands-dir=./build",
    "--log=verbose",  -- Enable verbose logging
    "--background-index",  -- Enable background indexing
  },
})

-- omnisharp setup
lspconfig.omnisharp.setup({
  cmd = { "omnisharp" },
  capabilities = capabilities,
  on_attach = on_attach,
  enable_import_completion = true,
  organize_imports_on_format = true,
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
})

-- typescript setup
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
})

-- angularls setup (make sure `ngserver` is in your PATH, installed via `npm i -g @angular/language-server`)
lspconfig.angularls.setup({
  cmd = { "ngserver", "--stdio", "--tsProbeLocations", ".", "--ngProbeLocations", "." },
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern("angular.json", "package.json", ".git"),
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
})

-- cssls setup (for css/scss/less)
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "css", "scss", "less" },
})

-- r_language_server setup
lspconfig.r_language_server.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "r", "rmd" },
})

-- haskell setup
lspconfig.hls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
})
