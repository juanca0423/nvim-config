-- =============================================================================
-- KEYMAPS GENERALES (Archivos y Sistema)
-- =============================================================================
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Guardar" })
vim.keymap.set('n', '<leader>W', ':wq<CR>', { desc = "Guardar y Salir" })
vim.keymap.set('n', '<leader>q', ':bdelete<CR>', { desc = "Cerrar Buffer actual" })
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true, desc = "Explorador de archivos" })
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = "Siguiente pestaña" })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = "Pestaña anterior" })

-- =============================================================================
-- LSP: INTELIGENCIA Y ERRORES (gd, gr, etc.)
-- =============================================================================
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Ir a Definición" })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Ir a Implementación" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Ver Referencias" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Ver Documentación (Hover)" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Renombrar símbolo" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Acciones de código (Fix)" })
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = "Ayuda de firma" })

-- Diagnósticos (Errores y Warnings)
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Siguiente Error" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Error Anterior" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Ver Error flotante" })
vim.keymap.set('n', '<leader>v', function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle Texto Virtual" })

-- =============================================================================
-- TELESCOPE: BUSCADORES
-- =============================================================================
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Buscar Archivos" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Buscar Texto (Grep)" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buscar Buffers" })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Archivos Recientes" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Buscar Ayuda" })
vim.keymap.set("n", "<leader>h", ":Telescope yank_history<CR>", { desc = "Historial de Portapapeles" })
vim.keymap.set('n', '<leader>fn', function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = 'Buscar en Config de Neovim' })

-- =============================================================================
-- DAP: DEBUGGING (Depuración)
-- =============================================================================
local dap = require('dap')
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Poner/Quitar Breakpoint" })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Debug: Iniciar/Continuar" })
vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = "Debug: Saltar línea" })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Debug: Entrar a función" })
vim.keymap.set('n', '<leader>do', dap.step_out, { desc = "Debug: Salir de función" })
vim.keymap.set('n', '<leader>dr', dap.restart, { desc = "Debug: Reiniciar" })
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, { desc = "Interfaz de Debug" })

-- DAP Go (Tests)
vim.keymap.set('n', '<leader>gt', function() require('dap-go').debug_test() end, { desc = "Debug Test Go" })

-- =============================================================================
-- OTROS: TERMINAL, GIT, HTTP Y SNIPPETS
-- =============================================================================
vim.keymap.set('n', '<leader>gg', ':term lazygit<CR>', { desc = "Lazygit" })
vim.keymap.set('n', '<leader>hr', function() require('kulala').run() end, { desc = "Petición HTTP" })
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = "Salir modo terminal" })

-- Luasnip (Navegación dentro de Snippets)
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-k>", function() if ls.expand_or_jumpable() then ls.expand_or_jump() end end)
vim.keymap.set({ "i", "s" }, "<C-j>", function() if ls.jumpable(-1) then ls.jump(-1) end end)

-- Plegado (UFO)
vim.keymap.set('n', '<leader>zz', 'za', { desc = "Plegar bloque" })
vim.keymap.set('n', 'zk', function() require('ufo').peekFoldedLinesUnderCursor() end, { desc = "Vista previa pliegue" })

-- Ejecutar la línea actual de SQL o el bloque seleccionado
vim.keymap.set("v", "<leader>rq", ":DB<CR>", { desc = "Ejecutar consulta SQL (Visual)" })
vim.keymap.set("n", "<leader>rq", "V:DB<CR>", { desc = "Ejecutar línea SQL actual" })

-- Ejecutar consulta y guardar como JSON (selecciona el SQL en modo visual y presiona ,bj)
vim.keymap.set("v", "<leader>bj", ":DB --format json<CR>", { desc = "Resultado SQL a JSON" })

-- Si quieres que se guarde en un archivo físico automáticamente:
vim.api.nvim_create_user_command('SqlToJson', function()
  local file = vim.fn.input('Nombre del archivo (ej: datos.json): ')
  if file ~= "" then
    vim.cmd('vno <leader>bj :DB --format json > ' .. file .. '<CR>')
    print("\n[SQL] Resultado se guardará en " .. file)
  end
end, {})

-- Abrir la guía de teclas en un split vertical
vim.keymap.set('n', '<leader>?', function()
  local path = vim.fn.stdpath("config") .. "/CHEATSHEET.md"
  vim.cmd("vsplit " .. path)
end, { desc = "Ver Guía de Atajos" })


-- Saltar al siguiente bloque {{#...}} o {{/...}}
vim.keymap.set('n', ']]', [[/{{[#/].*}}<CR>]], { silent = true })

vim.keymap.set('n', '[[', [[?{{[#/].*}}<CR>]], { silent = true })

-- Saltar a la siguiente función (Go: func, JS: function/const name =)
vim.keymap.set('n', 'gf', [[/\vfunc|function|const.* \=\>|async\s+function<CR>]],
  { desc = 'Siguiente Función', silent = true })

-- Saltar a la función anterior
vim.keymap.set('n', 'ga', [[?\vfunc|function|const.* \=\>|async\s+function<CR>]],
  { desc = 'Función Anterior', silent = true })
