local function conf()
  ---@diagnostic disable-next-line: undefined-field
  ---require('lualine').setup({ ... }))
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
        { 'filename', file_status = true, path = 1}
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


