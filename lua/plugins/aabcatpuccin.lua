return{
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Cargar antes que lo demásconfi
  config = function()
    require("catppuccin").setup({
      flavour = "latte", -- latte, frappe, macchiato, mocha
      term_colors = true, -- Esto ayuda a que los colores resalten más en terminal
      integrations={
        bufferline=true,
      }
    })
    vim.cmd.colorscheme "catppuccin"
  end
--ranja claro
--vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F9E2AF", bold = true }) -- amarilloSobrescribe solo el grupo de los
--números de línea
--vim.api.nvim_set_hl(0, "LineNr",       { fg = "#FAB387", bold = true }) -- naranja claroi
--blue  sky / sapphire
--green green / teal
--peach red / maroon
--yellow  flamingo / rosewater
--
--vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.red,     bg = colors.mantle })
-- vim.api.nvim_set_hl(0, "SignColumn", { fg = colors.teal,    bg = colors.mantle })
--vim.api.nvim_set_hl(0, "LineNr",     { fg = colors.flamingo, bold = true })
}
