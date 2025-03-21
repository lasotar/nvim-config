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
  end,
})
