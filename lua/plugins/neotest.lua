return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',   -- motor de parsers
      'nvim-neotest/neotest-go',
    },
    config = function()
      vim.g.neotest_root = vim.fn.getcwd()
      require('neotest').setup({
        adapters = {
          -- Elige el tuyo ↓↓↓
          --require('neotest-python')({}),   -- pytest / unittest
          -- require('neotest-jest')({}),  -- JavaScript / TypeScript
          require('neotest-go')({}),    -- Go
          -- require('neotest-plenary')({})-- Lua
        },{
          discovery={
            enable=true,
            filter_dir=function (name)
              return name ~= "vendor"
            end
          }
        },{
          status={
            enable=true,
            signs=true
          },
          diagnotic={enable=true},
          floating={
            border="rounded",
            max_height=0.8,
            max_width=0.9,
            options={}
          },
          strategies={
            integrated={
              width=125
            }
          }
        }
      })
    end
  },
  -- Adaptadores por lenguaje (cámbialos según necesites)
  -- { 'nvim-neotest/neotest-python', lazy = true },
  -- { 'nvim-neotest/neotest-jest', lazy = true },
  { 'nvim-neotest/neotest-go', lazy = true },
}
