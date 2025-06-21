-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "tsserver", "cssls", "omnisharp" },
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

-- clangd setup
lspconfig.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    "clangd",
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

-- tsserver setup (typescript/javascript)
lspconfig.tsserver.setup({
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
