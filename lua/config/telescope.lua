-- lua/config/telescope.lua
require('telescope').setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical={
        mirror=true,
        prompt_position="top",
      }
    },
    sorting_strategy = "ascending",
  },
})

-- Al final de lua/config/telescope.lua
require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')
-- Dentro de la configuración de Telescope o Yanky
require("telescope").load_extension("yank_history")

