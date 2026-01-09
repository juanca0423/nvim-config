local function conf()
  require('gitsigns').setup({
    current_line_blame = true, -- Muestra quién hizo el cambio en la línea actual
  })
end

return{
  'lewis6991/gitsigns.nvim',
  config = conf
}
