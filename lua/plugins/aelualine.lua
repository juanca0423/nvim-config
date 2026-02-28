local function harpoon_status()
  local ok, harpoon = pcall(require, "harpoon")
  if not ok then return "" end

  local list = harpoon:list()
  local marks = list.items
  local current_file_path = vim.fn.expand("%:p:.")

  for i, item in ipairs(marks) do
    if item.value == current_file_path then
      -- Usamos un color de la paleta Catppuccin (Flamingo/Pink)
      return "󰛢 " .. i
    end
  end
  return ""
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local cp = require("catppuccin.palettes").get_palette("mocha")

    require('lualine').setup({
      options = {
        theme = 'catppuccin',
        -- En Termux, los separadores redondos suelen alinearse mejor que los picudos
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        globalstatus = true, -- Mantiene una sola barra aunque abras varios splits
        disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 }
        },
        lualine_b = {
          'branch',
          { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } }
        },
        lualine_c = {
          { 'filetype', icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { 'filename', file_status = true, path = 1, symbols = { modified = ' ', readonly = ' ' } },
          { harpoon_status, color = { fg = cp.pink, gui = "bold" } }
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = '󰋽 ', hint = '󰌵 ' },
            colored = true,
          },
        },
        lualine_y = {
          { 'progress', color = { gui = "bold" } }
        },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
    })
  end
}


--[[/*
local function harpoon_status()
  -- Seguridad: Verifica si harpoon está cargado
  local ok, harpoon = pcall(require, "harpoon")
  if not ok then return "" end

  local list = harpoon:list()
  if not list then return "" end

  local marks = list.items
  local current_file_path = vim.fn.expand("%:p:.")

  for i, item in ipairs(marks) do
    if item.value == current_file_path then
      return "󰛢 " .. i
    end
  end
  return ""
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'catppuccin',
        -- Separadores: En Termux a veces los  se ven un poco desplazados.
        -- Si eso pasa, prueba con 'thin' o 'none'.
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          { 'filename',     file_status = true,                      path = 1 }, -- path = 1 muestra ruta relativa
          { harpoon_status, color = { fg = "#f5c2e7", gui = "bold" } } -- Color más acorde a Catppuccin
        },
        lualine_x = {
          {
            'diagnostics',
            symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
          },
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      }
    })
  end
}
*/]]
