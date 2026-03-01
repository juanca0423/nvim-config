return {
  -- El motor principal para manejar SQL
  {
    "tpope/vim-dadbod",
    lazy = true,
  },
  -- La interfaz gráfica (UI) y el autocompletado
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Configuración de la Interfaz
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_navigation = 1
      vim.g.db_ui_winwidth = 35

      -- Atajo rápido: Coma (tu leader) + db para abrir el panel
      vim.keymap.set('n', '<leader>bd', ':DBUIToggle<CR>', { desc = "Alternar Panel de DB" })
    end,
  },
}
