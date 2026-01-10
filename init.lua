-- ~/.config/nvim/init.lua
vim.g.mapleader = ","
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- ~/.config/nvim/init.lua  (arriba del return de plugins)
vim.g["test#go#recognize_tests"] = 1   -- obliga a reconocer tests
-- 1. lazy con prioridad para nuestras queries
require("lazy").setup("plugins")

-- 2. resto de tu config
vim.opt.termguicolors = true
vim.opt.background = "dark"
require("mapas")
require("opciones")
vim.o.clipboard = "unnamedplus"

-- resaltar yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Resaltar texto al copiar",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- formateo Go al guardar
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function() vim.lsp.buf.format() end,
})

-- asegurar que treesitter arranque en Go
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.defer_fn(function() vim.treesitter.start() end, 10)
  end,
})
