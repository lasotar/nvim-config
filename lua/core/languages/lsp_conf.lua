-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd" }, -- Install clangd for C/C++
})

-- LSP setup
local lspconfig = require("lspconfig")

-- clangd setup
lspconfig.clangd.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    client.server_capabilities.signatureHelpProvider = false
  end,
  cmd = {
    "clangd",
    "--log=verbose",  -- Enable verbose logging
    "--background-index",  -- Enable background indexing
  },
})

lspconfig.omnisharp.setup({
  cmd = { "omnisharp" },
  enable_import_completion = true,
  organize_imports_on_format = true,
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
})
