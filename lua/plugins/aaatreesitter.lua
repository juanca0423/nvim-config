return {
  "nvim-treesitter/nvim-treesitter",
  lazy=false,
  build = ":TSUpdate",
  Config = function()
    --vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/queries")
    require('nvim-treesitter.configs').setup({
  -- Instalación de lenguajes automática  
    ensure_installed = {"lua", "python", "javascript", "bash","go", "vim", "vimdoc"},
  -- Resaltado basado en el árbol de sintaxis
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
  -- Indentación inteligente
      indent = {
        enable = true
      }
    })
  end
}

