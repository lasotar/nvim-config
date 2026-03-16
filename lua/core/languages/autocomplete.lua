local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- Use LuaSnip for snippets
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-l>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP source
    { name = "buffer" }, -- Buffer source
    { name = "path" }, -- Path source
    { name = "luasnip" }, -- Snippet source
    { name = "copilot_chat" }, -- Autocomplete for @file, @buffer, etc. in Chat
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Add icons for different sources
      vim_item.menu = ({
        copilot = "[Copilot]",
        copilot_chat = "[Chat]",
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        path = "[Path]",
        luasnip = "[Snip]",
      })[entry.source.name]
      return vim_item
    end,
  },
  preselect = cmp.PreselectMode.Item, -- Auto-select the first item
})

-- Fix for CopilotChat completion
cmp.setup.filetype("copilot-chat", {
  sources = cmp.config.sources({
    { name = "copilot_chat" },
    { name = "buffer" },
    { name = "path" },
  }),
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
