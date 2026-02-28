return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      show_end_of_buffer = false, -- Oculta las '~' al final del archivo
      term_colors = true,

      -- Mejoramos los estilos de los componentes
      styles = {
        comments = { "italic" },
        conditionals = { "bold" },
        loops = { "bold" },
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold", "italic" },
        properties = {},
        types = { "bold" },
        operators = {},
      },

      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" }, -- Hace que el error sea una ondita, no una línea plana
            warnings = { "undercurl" },
          },
        },
        mason = true,
        telescope = { enabled = true },
        which_key = true,
        gitsigns = true,
        cmp = true,    -- Importante para que el menú de autocompletado se vea bien
        fidget = true, -- Para la notificación de carga del LSP
      },

      custom_highlights = function(colors)
        return {
          -- 1. Números de Línea (Tu mejora con esteroides)
          CursorLineNr = { fg = colors.peach, bold = true },
          LineNr = { fg = colors.surface2 }, -- Un gris más visible que overlay pero sutil

          -- 2. SignColumn y UI
          SignColumn = { bg = colors.none },
          VertSplit = { fg = colors.surface0 }, -- Línea divisoria entre paneles más elegante

          -- 3. Resaltado de búsqueda (Más tipo "VIM" clásico pero estilo Catppuccin)
          Search = { bg = colors.surface2, fg = colors.mauve, bold = true },
          CurSearch = { bg = colors.mauve, fg = colors.base },

          -- 4. Sugerencia de autocompletado (Ghost Text)
          SuggestWidget = { fg = colors.surface2 },

          -- 5. Pncctuación y Delimitadores (Para que el código se vea más limpio)
          ["@punctuation.bracket"] = { fg = colors.overlay2 },
          ["@punctuation.delimiter"] = { fg = colors.overlay2 },
        }
      end,
    })

    vim.cmd.colorscheme "catppuccin"
  end,
}
