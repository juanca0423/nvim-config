vim.g.perl_host_prog = '/data/data/com.termux/files/usr/bin/perl'
vim.g.python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.updatetime = 500
vim.opt.timeoutlen = 1500
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"

-- Configuración de cómo se muestran los diagnósticos
vim.diagnostic.config({
  virtual_text = {prefix = '*'},
  signs = true,        -- Activa los iconos en el margen izquierdo
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,--'always',
  },
})

-- Definición moderna de iconos (compatible con Neovim 0.10+)
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Esto asegura que los diagnósticos usen esos iconos
--  .
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Info,
    },
  },
})

vim.opt.cmdheight = 0 -- Solo aparece cuando escribes un comando

-- --- Mostrar errores automáticamente al detener el cursor ---

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    -- Verificamos el modo de forma más segura
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'n' then
      vim.diagnostic.open_float(nil, {
        focusable = false,
        scope = "cursor",
        border = "rounded",
        source = "always",
      })
    end
  end,
})
