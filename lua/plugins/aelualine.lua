local function harpoon_status()
  local ok, harpoon = pcall(require, "harpoon")
  if not ok then return "" end
  local current_file_path = vim.fn.expand("%:p:.")
  local marks = harpoon:list().items
  for i, item in ipairs(marks) do
    if item.value == current_file_path then return "   " .. i end
  end
  return ""
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'catppuccin/nvim'
  },
  config = function()
    require('lualine').setup({
      options = {
        theme = require('lualine.themes.catppuccin-mocha'),
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          { 'filetype', icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { 'filename', path = 1 },
          {
            harpoon_status,
            color = function()
              -- Esto solo se ejecuta cuando la barra se dibuja, evitando el error de carga
              local ok, cp = pcall(require, "catppuccin.palettes")
              return { fg = ok and cp.get_palette("mocha").pink or "#f5c2e7" }
            end
          }
        },
        lualine_x = {
          {
            function()
              local msg = 'No LSP'
              local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if next(clients) == nil then return msg end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name -- Muestra el nombre (ej. 'gopls' o 'tsserver')
                end
              end
              return msg
            end,
            icon = ' LSP:',
            color = { fg = '#ffffff', gui = 'bold' },
          },
          'diagnostics',
        },
        lualine_y = { 'progress' },
        lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
      },
    })
  end
}
