return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- BLOQUE DE SEGURIDAD: Evita que el error bloquee Neovim
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      return -- Si falla, no hace nada y no lanza el error rojo
    end

    -- Configuración del compilador para Termux
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.install').compilers = { "clang" }

    configs.setup({
      ensure_installed = { "lua", "javascript", "html", "css", "go", "glimmer" },
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    })

    vim.treesitter.language.register('glimmer', 'handlebars')
  end,
}
