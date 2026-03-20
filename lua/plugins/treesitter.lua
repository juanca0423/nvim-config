return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- IMPORTANTE: En versiones nuevas, a veces el modulo se carga distinto.
    -- Intentamos cargar el setup de forma segura.
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return   -- Si falla, no rompe el inicio de Neovim
    end

    -- Configuraciones específicas para Termux (Compilador)
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.install').compilers = { "clang" }

    configs.setup({
      -- Asegúrate de incluir 'go' y 'handlebars' aquí
      ensure_installed = {
        "lua", "go", "javascript", "typescript", "tsx",
        "html", "css", "handlebars", "glimmer", "json"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      autotag = { enable = true },

      -- Activamos los saltos de funciones [f y ]f
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]m"] = "@method.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[m"] = "@method.outer",
          },
        },
      },
    })

    -- Registrar lenguajes manualmente para evitar fallos en vistas .hbs
    vim.treesitter.language.register("glimmer", "handlebars")
    vim.treesitter.language.register("javascript", "javascriptreact")
  end,
}
