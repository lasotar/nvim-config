local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- Use LuaSnip for snippets
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP source
    { name = "buffer" }, -- Buffer source
    { name = "path" }, -- Path source
    { name = "luasnip" }, -- Snippet source
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Add icons for different sources
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
        luasnip = "[Snip]",
      })[entry.source.name]
      return vim_item
    end,
  },
  experimental = {
    ghost_text = true, -- Enable ghost text
  },
  preselect = cmp.PreselectMode.Item, -- Auto-select the first item
})

-- Enable command-line completion
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }, -- File paths
    { name = "cmdline" }, -- Command-line history
  }),
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }, -- Buffer content
  },
})
