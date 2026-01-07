local dap = require('dap')
local dapui = require('dapui')
local bufopts = { noremap=true, silent=true }

vim.g.mapleader=","

vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = "Listar buffers" })

--Pone el "punto rojo" donde se detendrá el código.
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)

-- Iniciar o continuar (Sustituye a F5)
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Debug: Continuar" })

-- Paso a paso / Saltar línea (Sustituye a F10)
vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = "Debug: Siguiente línea" })
vim.keymap.set("n", "<leader>df", ":lua require('neogen').generate()<CR>", { desc = "Generar Documentación" })

-- Entrar en función (Sustituye a F11)
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Debug: Entrar a función" })

-- Salir de función (Sustituye a F12)
vim.keymap.set('n', '<leader>do', dap.step_out, { desc = "Debug: Salir de función" })

-- Poner/Quitar punto de interrupción
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Debug: Breakpoint" })

-- Reiniciar sesión de debug
vim.keymap.set('n', '<leader>dr', dap.restart, { desc = "Debug: Reiniciar" })

-- Detener debug y cerrar interfaz
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, { desc = "Toggle Debug UI" })

vim.keymap.set("n","<leader>e",":Ex<CR>")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>gg', ':term lazygit<CR>', { desc = "Abrir Lazygit" })

-- Atajos específicos para Go Tests
vim.keymap.set('n', '<leader>gt', function() require('dap-go').debug_test() end, { desc = "Depurar Test actual" })

vim.keymap.set('n', '<leader>gl', function() require('dap-go').debug_last_test() end, { desc = "Depurar último Test" })
-- -- Atajo para ver el historial
vim.keymap.set("n", "<leader>h", ":Telescope yank_history<CR>", { desc = "Historial de copiado" })

  -- Peticiones HTTP
vim.keymap.set('n', '<leader>hr', function() require('kulala').run() end, { desc = "Ejecutar petición HTTP" })

vim.keymap.set('n', '<leader>hn', function() require('kulala').jump_next() end, { desc = "Siguiente petición" })

vim.keymap.set('n', '<leader>hp', function() require('kulala').jump_prev() end, { desc = "Petición anterior" })
-- Cerrar buffer actual con un atajo rápido
vim.keymap.set('n', '<leader>q', ':bdelete<CR>', { desc = "Cerrar archivo" })
    
-- Renombrar variable/función en todo el proyecto
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Renombrar símbolo" })

-- Abrir terminal abajo
vim.keymap.set('n', '<leader>st', ':sp | terminal<CR>i', { desc = "Abrir Terminal" })

-- Ejecutar tests de Go normales en la terminal de Neovim
vim.keymap.set('n', '<leader>tf', ':term go test -v %<CR>', { desc = "Correr tests del archivo actual" })

-- Este mapeo arregla el error "undefined" y activa los iconos
vim.keymap.set('n', '<leader>tr', function()
  require("neotest").run.run(vim.fn.getcwd())
end, {desc = "Correr tests del paquete completo"})

-- Correr solo el test más cercano al cursor
vim.keymap.set('n', '<leader>tn', function()
    require("neotest").run.run()
end, { desc = "Correr test cercano" })

-- Ver la salida detallada (importante para ver por qué fallan)
vim.keymap.set('n', '<leader>to', function() 
    require("neotest").output.open({ enter = true })
end, { desc = "Ver salida del test" })

vim.keymap.set('n', '<leader>ts', function() require('neotest').summary.toggle() end, { desc = "Ver Sumario de Tests" })

-- Correr test y mandar errores a una lista visible
vim.keymap.set('n', '<leader>tt', function()
    -- Ejecuta go test y captura la salida
    vim.cmd('set makeprg=go\\ test\\ -v')
    vim.cmd('make %')
    -- Abre la ventana de errores abajo si hay fallos
    vim.cmd('copen')
end, { desc = "Ejecutar Go Test Profesional" })

vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>W', ':wq<CR>')
vim.keymap.set('n', '<leader>ff', builtin.find_files,{})
vim.keymap.set('n', '<leader>fg', builtin.live_grep,{})
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })

-- Ir a la definición (El sustituto moderno y potente)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--
-- -- Ver implementaciones (Útil en Go para interfaces)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--
-- -- Ver dónde se usa una función/variable
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
-- -- Ver firma de la función (qué argumentos recibe)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--
-- Ver documentación (Hover)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Ver documentación" })

-- Ver ayuda de firma (mientras escribes los argumentos)
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = "Ayuda de firma" })

-- Salir de la terminal más fácil con Esc Esc
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = "Salir modo terminal" })

require("toggleterm").setup({
  size = 15, -- Tamaño de la terminal
  open_mapping = [[<C-\>]], -- Con Ctrl + \ la abres y cierras
  shade_terminals = true,
  direction = 'horizontal', -- Aparece abajo. También puedes usar 'float'
  close_on_exit = true,
})

-- Función para que Esc Esc funcione dentro de ToggleTerm
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
end

-- Solo oculta el texto flotante (virtual text)
vim.keymap.set('n', '<leader>v', function()
  local is_enabled = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not is_enabled })
end)

vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = "Siguiente pestaña" })

vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = "Pestaña anterior" })

-- Abrir/Cerrar el bloque donde está el cursor (Toggle)
-- -- 'za' es el comando estándar, pero puedes crear uno con leader si prefieres:
vim.keymap.set('n', '<leader>zz', 'za', { desc = "Plegar/Desplegar bloque" })
--
-- -- Abrir todos los pliegues (Desplegar todo el archivo)
vim.keymap.set('n', 'zr', require('ufo').openAllFolds, { desc = "Abrir todos los pliegues" })
--
-- -- Cerrar todos los pliegues (Colapsar todo el archivo)  
vim.keymap.set('n', 'zm', require('ufo').closeAllFolds, { desc = "Cerrar todos los pliegues" })
--
-- -- Peek Fold (Ver qué hay dentro de un pliegue sin abrirlo)
-- -- Esto es genial: te muestra una ventanita flotante con el contenido
vim.keymap.set('n', 'zk', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover() -- Si no hay pliegue, intenta mostrar información de LSP
  end
end, { desc = "Vista previa del pliegue" })


