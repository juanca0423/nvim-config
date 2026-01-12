-- Función para obtener el estado de Harpoon
local function harpoon_status()
    local harpoon = require("harpoon")
    local marks = harpoon:list().items
    local current_file_path = vim.fn.expand("%:p:.")
    for i, item in ipairs(marks) do
        if item.value == current_file_path then
            return "󰛢 " .. i -- Muestra un icono de arpón y el número
        end
    end
    return ""
end

local function conf()
  ---@diagnostic disable-next-line: undefined-field
  require('lualine').setup({
    options = {
      theme = 'catppuccin',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''}
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        { 'filename', file_status = true, path = 1},
        { harpoon_status, color = { fg = "#ff007c", gui = "bold" } }
      },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = '󰌵 ',
          },
          diagnostics_color = {
            error = {fg = '#f38ba8'},
            warn = {fg = '#f9e2af'},
          }
        },
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    }
  })

end

return{
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = conf
}


