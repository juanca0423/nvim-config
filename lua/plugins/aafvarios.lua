return{
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Recomendado para tener las últimas funciones
    build = "make install_jsregexp" -- Opcional: para soporte de regex avanzado
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true -- Esto ejecuta la configuración básica automáticamente
  },
  {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = true
  },
  {
    "rafamadriz/friendly-snippets",
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true -- Esto ejecuta la configuración básica automáticamente
  },
  { "lspkind.nvim",},
  { 'onsails/lspkind.nvim' },
  { 'nvim-tree/nvim-web-devicons',
    require('nvim-web-devicons').setup({
     -- Podemos personalizar iconos específicos aquí si quisiéramos
       default = true; -- Usa un icono por defecto si no encuentra uno específico
     --  })
    })
  },
  {
    'mistweaverco/kulala.nvim',
    config = function()
      require('kulala').setup({})
    end
  },
}
