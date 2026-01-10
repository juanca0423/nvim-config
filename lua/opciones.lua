vim.g.perl_host_prog = '/data/data/com.termux/files/usr/bin/perl'
vim.g.python3_host_prog = '/data/data/com.termux/files/usr/bin/python3.12'

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.relativenumber = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 1500
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.backup = false       -- No crea archivos .bak
vim.opt.writebackup = false  -- No crea respaldos antes de guardar
vim.opt.swapfile = false
vim.opt.signcolumn = "yes:2"
vim.cmd([[highlight NeotestPassed guifg=#00FF00 gui=bold]])

-- Configuración de cómo se muestran los diagnósticos
vim.diagnostic.config({
  virtual_text = true, -- Muestra el error al final de la línea
  signs = true,        -- Activa los iconos en el margen izquierdo
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,--'always',
  },
})

local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.opt.cmdheight = 0 -- Solo aparece cuando escribes un comando

-- --- Mostrar errores automáticamente al detener el cursor ---

-- Tiempo en milisegundos que el cursor debe estar quieto (500ms es equilibrado)
vim.opt.updatetime = 500

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    -- Solo abre la ventana si hay un error (diagnóstico) bajo el cursor
    vim.diagnostic.open_float(nil, {
        focusable = false,
        close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
        border = "rounded",
        source = "always", -- Te dice si el error viene de Go, Neotest, etc.
        prefix = " ",
        scope = "cursor",
    })
  end,
})

vim.cmd([[highlight DiagnosticSignError guifg=#FF0000]])
vim.opt.signcolumn = "yes"

