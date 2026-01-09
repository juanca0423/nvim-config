return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',   -- motor de parsers
    },
    config = function()
      require('neotest').setup({
        adapters = {
          -- Elige el tuyo ↓↓↓
          --require('neotest-python')({}),   -- pytest / unittest
          -- require('neotest-jest')({}),  -- JavaScript / TypeScript
          require('neotest-go')({}),    -- Go
          -- require('neotest-plenary')({})-- Lua
        },
      })
    end,
    keys = {
      { '<leader>tt', function() require('neotest').run.run() end, desc = 'Ejecutar test más cercano' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Ejecutar archivo' },
      { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Abrir/cerrar panel' },
      { '<leader>to', function() require('neotest').output.open({ enter = true }) end, desc = 'Ver salida del test' },
    },
  },

  -- Adaptadores por lenguaje (cámbialos según necesites)
  -- { 'nvim-neotest/neotest-python', lazy = true },
  -- { 'nvim-neotest/neotest-jest', lazy = true },
  { 'nvim-neotest/neotest-go', lazy = true },
}
