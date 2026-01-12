
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500, -- Aparece medio segundo después de dejar el cursor quieto
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Navegar entre cambios (Hunks)
        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Siguiente cambio Git"})

        vim.keymap.set('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Cambio Git anterior"})

        -- Atajo para ver los cambios de la línea en una ventana flotante
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = "Previsualizar cambio" })
      end
    })
  end
}
