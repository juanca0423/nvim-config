local cmp = require'cmp'
local lspkind = require("lspkind")
cmp.setup({
  snippet = {
    expand = function(args)
    require('luasnip').lsp_expand(args.body) -- Necesario para los snippets
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 'Enter' para confirmar
    ['<Tab>'] = cmp.mapping.select_next_item(),       -- 'Tab' para bajar
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),   -- 'Shift+Tab' para subir
  }),
  completion = {
        -- TextChanged activa el menú automáticamente al escribir ✍️
    autocomplete = { cmp.TriggerEvent.TextChanged },
        --         -- 1 significa que aparecerá desde la primera letra que escribas
    keyword_length = 1,
  },
    formatting = {
      fields = {"kind", "abbr", "menu"},
      format = function(entry, vim_item)
      local kind = lspkind.cmp_format({
        mode = 'symbol_text',
        preset = 'default',
        maxwidth = 50,
        ellipsis_char = '...',
        symbol_map = {
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
          Value = "󰎟",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈚",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        }
      })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = " (" .. (strings[2] or "") .. ")"

      return kind
       end,
    },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- Sugerencias del servidor de lenguaje
    { name = 'luasnip' },  -- Sugerencias de fragmentos de código
  }, {
    { name = 'buffer' },   -- Sugerencias basadas en palabras del archivo actual
    { name = 'path' },     -- Sugerencias de rutas de archivos
  })
})

local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
    luasnip.lsp_expand(args.body) -- Permite que LuaSnip expanda el código
  end,
},
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'luasnip' }, -- Añadimos LuaSnip como fuente de sugerencias 💡
}, {
  { name = 'buffer' },
}),

  luasnip.add_snippets("go", {
    luasnip.snippet("iferr", {
      luasnip.text_node("if err != nil {"),
      luasnip.insert_node(1, "return err"), -- El cursor saltará aquí primero
      luasnip.text_node({"", "}"}),
    }),
  }),

})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)



