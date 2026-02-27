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
