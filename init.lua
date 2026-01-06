local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("opciones")
require("lazy").setup("plugins")
require("mapas")
-- Cargar configuraciones de plugins
require("config.telescope")
--require("config.treesitter")
require("config.lsp")
require("config.cmp")  -- El que creamos para el autocompletado
vim.o.clipboard = "unnamedplus"

-- Resaltar texto al copiar (yank)
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Resaltar texto al copiar",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- El color del destello (puedes usar 'Visual' o 'IncSearch')
      timeout = 200,         -- Duración en milisegundos (200ms es un destello rápido)
    })
  end,
})


