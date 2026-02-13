return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      -- Cambié a 'mocha' (oscuro) porque en pantallas OLED/Móvil se ve mejor,
      -- pero si prefieres claro, vuelve a poner 'latte'.
      flavour = "mocha",
      term_colors = true,
      transparent_background = false,
      integrations = {
        bufferline = true,
        treesitter = true,
        mason = true,
        nvimtree = true,
        telescope = { enabled = true },
        lsp_trouble = true,
        which_key = true,
      },
      -- AQUÍ es donde forzamos los colores de los números

      custom_highlights = function(colors)
        return {
          -- 1. El número donde estás parado (Naranja brillante)
          CursorLineNr = { fg = colors.peach, bold = true },

          -- 2. LOS NÚMEROS DE LAS DEMÁS LÍNEAS (Aquí estaba el problema)
          -- 'overlay1' es muy suave, usemos 'subtext0' o un color directo
          LineNr = { fg = colors.subtext0, bold = false },

          -- 3. La columna de los símbolos de Git (La que ves con '2┃')
          -- La ponemos transparente para que no cree un bloque de color distinto
          SignColumn = { bg = colors.none },

          -- 4. Si quieres que los símbolos de Git también resalten:
          GitSignsAdd = { fg = colors.green },
          GitSignsChange = { fg = colors.yellow },
          GitSignsDelete = { fg = colors.red },
        }
      end,
    })

    vim.cmd.colorscheme "catppuccin"
  end,
}
