require('nvim-treesitter.configs').setup({
  -- Instalación de lenguajes automática
  ensure_installed = {"lua", "python", "javascript", "bash","go"},
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

