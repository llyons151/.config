--------------------------------------------------
-- nvim-cmp pretty setup
--------------------------------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

--------------------------------------------------
-- Icons
--------------------------------------------------
local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
}

--------------------------------------------------
-- Helper
--------------------------------------------------
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then return false end
  local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  return text:sub(col, col):match("%s") == nil
end

--------------------------------------------------
-- Setup
--------------------------------------------------
cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = { autocomplete = false },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  --------------------------------------------------
  -- Pretty windows
  --------------------------------------------------
  window = {
    completion = cmp.config.window.bordered({
      border = "rounded",
      winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:None",
    }),
    documentation = cmp.config.window.bordered({
      border = "rounded",
    }),
  },

  --------------------------------------------------
  -- Nice formatting
  --------------------------------------------------
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, item)
      item.kind = string.format("%s ", kind_icons[item.kind])
      item.menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buf]",
        path = "[Path]",
        luasnip = "[Snip]",
      })[entry.source.name]
      return item
    end,
  },

  --------------------------------------------------
  -- Mappings
  --------------------------------------------------
  mapping = cmp.mapping.preset.insert({

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping.select_prev_item(),

    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    ["<C-Space>"] = cmp.mapping.complete(),
  }),

  --------------------------------------------------
  -- Sources
  --------------------------------------------------
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
})
