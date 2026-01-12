
return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("spectre").setup({
      is_insert_mode = true, -- Empieza en modo insertar para escribir rápido
    })
    
    -- Atajos de teclado
    -- Abrir el panel de búsqueda masiva
    vim.keymap.set('n', '<leader>x', '<cmd>lua require("spectre").toggle()<CR>', {
        desc = "Abrir Spectre (Buscar y reemplazar)"
    })
    
    -- Buscar la palabra que tienes bajo el cursor en todos los archivos
    vim.keymap.set('n', '<leader>xw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
        desc = "Cercar palabra actual con Spectre"
    })
  end,
}
