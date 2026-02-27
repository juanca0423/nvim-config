-- Desactivar providers que no usas para acelerar el inicio
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0 -- También puedes desactivarlo si no usas plugins de Node antiguos
vim.g.python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'

-- Portapapeles (VITAL para Termux)
vim.opt.clipboard = "unnamedplus"

-- Interfaz y Comportamiento
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true -- Resalta la línea actual (ayuda visualmente)

-- Búsqueda y Tiempo
vim.opt.smartcase = true
vim.opt.ignorecase = true -- Necesario para que smartcase funcione
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400  -- Un poco más rápido para Termux

-- Tabulación (Estándar Go/JS/Lua)
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Archivos y Backup (Optimizado para memoria Flash de móviles)
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true -- ¡Añade esto! Permite deshacer cambios incluso después de cerrar el archivo

-- Menú de comandos (Wildmenu)
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"

-- =============================================================================
-- CONFIGURACIÓN DE DIAGNÓSTICOS (Unificada para v0.10+)
-- =============================================================================
local icons = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 4
  },
  -- En Neovim 0.10+, la tabla 'signs' cambió un poco de estructura.
  -- Esta es la forma más moderna y estable:
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN]  = icons.Warn,
      [vim.diagnostic.severity.HINT]  = icons.Hint,
      [vim.diagnostic.severity.INFO]  = icons.Info,
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always', -- Te dice qué LSP está dando el error (pyright, gopls, etc.)
    focusable = false,
  },
})
