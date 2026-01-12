
return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local dashboard = require('alpha.themes.dashboard')

    -- Arte ASCII minimalista (Gopher de Go)
    dashboard.section.header.val = {
      [[      ██████   ██████  ]],
      [[     ██       ██    ██ ]],
      [[     ██   ███ ██    ██ ]],
      [[     ██    ██ ██    ██ ]],
      [[      ██████   ██████  ]],
      [[                       ]],
      [[     JUAN CARLOS       ]],
      [[   GO • JAVASCRIPT     ]],
    }

    -- Botones con íconos de Catppuccin
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Buscar Archivo", ":Telescope find_files <CR>"),
      dashboard.button("r", "󰄉  Recientes", ":Telescope oldfiles <CR>"),
      dashboard.button("s", "󰈭  Buscar Texto", ":Telescope live_grep <CR>"),
      dashboard.button("c", "  Configuración", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("q", "󰅚  Salir", ":qa<CR>"),
    }

    -- FOOTER DINÁMICO (Plugins y Hora)
    local function footer()
      local stats = require("lazy").stats()
      local count = stats.count
      local datetime = os.date("  %H:%M:%S")
      return "󰚥 " .. count .. " Plugins cargados  •  " .. datetime
    end

    dashboard.section.footer.val = footer()

    -- COLORES (Ajuste para Catppuccin Mocha)
    -- "Comment" lo hace ver gris oscuro/azulino, muy elegante
    dashboard.section.header.opts.hl = "Character" 
    dashboard.section.footer.opts.hl = "Comment"
    
    -- Hacer que los botones no brillen tanto
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "Keyword"
      button.opts.hl_shortcut = "Type"
    end

    require('alpha').setup(dashboard.opts)
  end
}
