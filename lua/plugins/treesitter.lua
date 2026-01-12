
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- Solo cuando se abra un archivo, intentamos cargar el módulo
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    configs.setup({
      ensure_installed = { "glimmer", "lua", "javascript", "html", "css", "sql", "go" },
      highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
    
    -- Registrar Handlebars
    vim.treesitter.language.register('glimmer', 'handlebars')
  end,
}
