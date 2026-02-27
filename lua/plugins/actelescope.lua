return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local telescope = require('telescope')

      telescope.setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              mirror = true,        -- El prompt arriba, los resultados abajo
              prompt_position = "top",
              preview_height = 0.4, -- Da más espacio a la lista en pantallas pequeñas
            }
          },
          sorting_strategy = "ascending",
          -- Ignorar archivos pesados o binarios
          file_ignore_patterns = { "node_modules", ".git/", "target/" },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          }
        }
      })

      -- Cargar extensiones (Nota: yanky solo si lo tienes instalado)
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'yank_history')

      -- ATAJOS RÁPIDOS (Keymaps)
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Buscar archivos" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Buscar texto (grep)" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Ver buffers abiertos" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Buscar en la ayuda" })
    end,
  }
}
