return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  -- El evento 'BufReadPost' hace que cargue rápido al abrir un archivo
  event = { "BufReadPost", "BufNewFile" },

  config = function()
    -- 1. Definimos los colores/highlights
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require("ibl.hooks")

    -- 2. Registramos los hooks para los colores
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#4A86E8" }) -- Tu azul de Excel
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)

    -- 3. Ejecutamos el setup con las opciones
    require("ibl").setup({
      indent = {
        char = "▎",
        highlight = highlight
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = { "RainbowBlue" }, -- Resalta el scope actual con tu azul
      },
    })
  end,
}
