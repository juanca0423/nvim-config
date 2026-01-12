
-- Desactivar providers que no usas para acelerar el inicio
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'

-- Interfaz y Comportamiento
vim.opt.number = true           -- Número de línea actual
vim.opt.relativenumber = true   -- Números relativos (vital para saltos como 5j o 10k)
vim.opt.mouse = "a"             -- Mouse habilitado
vim.opt.signcolumn = "yes"      -- Columna izquierda fija (evita saltos de texto)
vim.opt.cmdheight = 0           -- Oculta la barra de comandos si no se usa
vim.opt.laststatus = 3          -- Barra de estado global (ahorra espacio si tienes splits)
vim.opt.termguicolors = true -- terminal color
vim.opt.background = "dark" --terminal obscura

-- Búsqueda y Tiempo
vim.opt.smartcase = true        -- Inteligente con mayúsculas
vim.opt.updatetime = 300        -- Más rápido para disparar eventos como CursorHold
vim.opt.timeoutlen = 500        -- Tiempo de espera para completar atajos (leader)

-- Tabulación (Estándar para Go/JS)
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2

-- Archivos y Backup (Menos escritura en disco para Termux)
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Menú de comandos (Wildmenu)
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"

-- CONFIGURACIÓN DE DIAGNÓSTICOS (Unificada)
local icons = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }

vim.diagnostic.config({
  virtual_text = { prefix = '●', spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.HINT] = icons.Hint,
      [vim.diagnostic.severity.INFO] = icons.Info,
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
    focusable = false,
  },
})

-- Mostrar error flotante automáticamente al dejar el cursor quieto
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    if vim.api.nvim_get_mode().mode == 'n' then
      vim.diagnostic.open_float(nil, { scope = "cursor" })
    end
  end,
})
