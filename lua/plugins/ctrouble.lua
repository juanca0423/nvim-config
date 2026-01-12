
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble", -- Solo carga el plugin cuando uses el comando
  opts = {
    mode = "diagnostics", -- modo por defecto
    auto_close = true,    -- se cierra solo si arreglas todo
    restore_window_config = false, -- ESTO suele evitar el error de 'Invalid window'
    padding = false,      -- ahorra espacio en Termux
  },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Todos los errores" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Errores del archivo" },
  },
}
