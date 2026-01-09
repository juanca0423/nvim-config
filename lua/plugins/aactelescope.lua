return{
  'nvim-telescope/telescope.nvim',
  dependencies = {'nvim-lua/plenary.nvim'},
  config = function()

-- lua/config/telescope.lua
  require('telescope').setup({
    defaults = {
      layout_strategy = "vertical",
      layout_config = {
        vertical={
          mirror=true,
          prompt_position="top",
        }
      },
      sorting_strategy = "ascending",
    },
  })

-- Al final de lua/config/telescope.lua
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('ui-select')
-- Dentro de la configuración de Telescope o Yanky
  require("telescope").load_extension("yank_history")
  end,
  {
    'nvim-telescope/telescope-fzf-native.nvim',
     build = 'make'
  },
    -- Extensión 2: UI-Select para menús bonitos 🎨
  {
    'nvim-telescope/telescope-ui-select.nvim'
  },
    -- LSP: El motor de inteligencia 🧠
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
    -- Autocompletado ⌨️
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Fuente para el LSP
      "hrsh7th/cmp-path",     -- Fuente para rutas de archivos
      "L3MON4D3/LuaSnip",     -- Motor de snippets (necesario)
      "saadparwaiz1/cmp_luasnip",
    },
  },
  { "lspkind.nvim",},
  { 'onsails/lspkind.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
}
