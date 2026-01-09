local function conf()
  -- Opciones recomendadas para UFO
  vim.o.foldcolumn = '1' -- '0' si no quieres ver la columna de plegado
  vim.o.foldlevel = 99 -- Empieza con todo desplegado
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  require('ufo').setup()
end

return{
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  config = conf
}
