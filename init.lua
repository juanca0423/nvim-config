
-- Leader primero
vim.g.mapleader = ","

-- 1. Carga de Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Plugins
require("lazy").setup("plugins", { rocks = { enabled = false } })

-- 3. Opciones y Mapas
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.o.clipboard = "unnamedplus"

require("mapas")
require("opciones")
require("config.misnipet") -- Asegúrate de que aquí 'f' sea 'function_node'

-- 4. Autocomandos y Fixes
-- Resaltar yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})

-- Formateo automático al guardar
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "*.js", "*.ts", "*.hbs", "*.html", "*.css" },
  callback = function()
    pcall(function() vim.lsp.buf.format({ timeout_ms = 1000 }) end)
  end,
})

-- Handlebars / Glimmer Config
vim.filetype.add({ extension = { hbs = "handlebars" } })
vim.treesitter.language.register('glimmer', 'handlebars')

-- Forzar resaltado en Handlebars
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.hbs",
  callback = function()
    vim.bo.filetype = "handlebars"
    pcall(vim.treesitter.start)
  end,
})
