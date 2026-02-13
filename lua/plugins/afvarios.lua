return {
  -- 1. Snippets Engine
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    -- En Termux, solo intenta compilar si tienes 'make' y 'clang' instalados
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- 2. Autopairs (Carga al entrar en modo insertar)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- Integración con Treesitter
    },
  },

  -- 3. Terminal Flotante
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]], -- Ctrl + \ para abrir/cerrar
      shade_terminals = true,
      direction = "float",
    },
  },

  -- 4. Iconos y Estética del LSP
  { "onsails/lspkind.nvim" },
  {
    "nvim-tree/nvim-web-devicons",
    opts = { default = true },
  },

  -- 5. Cliente HTTP (Alternativa a Postman/Insomnia)
  {
    "mistweaverco/kulala.nvim",
    ft = "http", -- Solo se carga cuando abres un archivo .http
    opts = {},
  },

  -- Autotag: Cierra y renombra etiquetas HTML automáticamente
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      opts = {
        -- Activa el autocerrado
        enable_close = true,
        -- Activa el autorenombrado (si cambias <div> por <section>, el cierre cambia solo)
        enable_rename = true,
        -- Activa el cierre al presionar '>'
        enable_close_on_slash = true,
      },
      -- Aquí forzamos que funcione en tus lenguajes
      per_filetype = {
        ["html"] = { enable_close = true },
        ["handlebars"] = { enable_close = true },
        ["hbs"] = { enable_close = true },
        ["javascriptreact"] = { enable_close = true },
        ["typescriptreact"] = { enable_close = true },
      }
    },
  },
}
