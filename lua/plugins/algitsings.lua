return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      -- Estética de los signos (más minimalista)
      signs = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        changedelete = { text = '▎' },
        untracked    = { text = '┆' },
      },

      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- al final de la línea
        delay = 500,
      },

      -- Mejora la visibilidad en temas oscuros
      current_line_blame_formatter = '<author> • <author_time:%R> • <summary>',

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navegación (Tus mapeos actuales están perfectos)
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Siguiente cambio Git" })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Cambio Git anterior" })

        -- ACCIONES ADICIONALES ÚTILES
        map('n', '<leader>gp', gs.preview_hunk, { desc = "Previsualizar cambio" })
        map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = "Blame completo (ventana)" })
        map('n', '<leader>gd', gs.diffthis, { desc = "Ver Diff contra el índice" })
      end
    })
  end
}
