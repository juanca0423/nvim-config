vim.g.mapleader=","
-- Forzamos a Neovim a ver la carpeta que ya confirmaste que existe
vim.opt.rtp:prepend("/data/data/com.termux/files/home/.local/share/nvim/lazy/nvim-treesitter")

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
require("lazy").setup("plugins")
vim.opt.termguicolors = true          -- RGB de verdad
vim.opt.background    = 'dark'        -- le dice al tema que use la variante oscura
require("mapas")
require("opciones")
-- Cargar configuraciones de plugins
--require("config.telescope")
--require("config.lsp")
--require("config.cmp")  -- El que creamos para el autocompletado
vim.o.clipboard = "unnamedplus"

-- Resaltar texto al copiar (yank)
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Resaltar texto al copiar",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- El color del destello (puedes usar 'Visual' o 'IncSearch')
      timeout = 200,
    })
  end,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format()
   end,
 })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    -- Esperamos 10ms para asegurar que el plugin cargó
    vim.defer_fn(function()
      vim.treesitter.start()
    end, 10)
  end,
})
