vim.g.mapleader = ","

-- 1. Carga de Lazy.nvim con corrección para el linter
local lazypath = vim.fn.stdpath("data") --[[@as string]] .. "/lazy/lazy.nvim"
local stat = vim.uv.fs_stat(lazypath)

if not stat then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Plugins
-- Nota: 'rocks.enabled = false' es bueno para evitar problemas de dependencias de Lua externas
require("lazy").setup("plugins", { rocks = { enabled = false } })

-- 3. Opciones y Mapas
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.o.clipboard = "unnamedplus"

-- Carga de módulos externos
require("mapas")
require("opciones")
require("config.misnipet")

-- 4. Autocomandos y Fixes
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Resaltar yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function() vim.hl.on_yank({ timeout = 200 }) end,
})

-- Si usas nvim-treesitter, asegúrate de tener instalado el parser de glimmer
vim.treesitter.language.register('glimmer', 'handlebars')

-- Forzar resaltado en Handlebars
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "*.hbs",
  callback = function()
    vim.bo.filetype = "handlebars"
    pcall(vim.treesitter.start)
  end,
})

-- Registro de tipos de archivo para limpiar Warnings del LspHealth
vim.filetype.add({
  extension = {
    hbs = 'handlebars',
    handlebars = 'handlebars',
    pug = 'pug',
    templ = 'templ',
    gowork = 'gowork',
    gotmpl = 'gotmpl',
  },
})

local cheatsheet_path = vim.fn.stdpath("config") .. "/CHEATSHEET.md"
local f = io.open(cheatsheet_path, "r")

if f == nil then
  local file = io.open(cheatsheet_path, "w")
  if file then
    file:write([[
# ⌨️ Neovim + Termux Pro Cheat Sheet

### 🚀 Generales y Navegación
| Tecla | Acción |
| :--- | :--- |
| `<leader>w` | Guardar archivo actual |
| `<leader>W` | Guardar y salir (`:wq`) |
| `<leader>q` | Cerrar Buffer actual |
| `Ctrl + n`  | Abrir/Cerrar explorador |
| `Tab`       | Siguiente pestaña |
| `S-Tab`     | Pestaña anterior |
| `<leader>?` | **Ver esta guía** |

### 🔍 Buscadores (Telescope)
| Tecla | Acción |
| :--- | :--- |
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Buscar texto (Grep) |
| `<leader>h`  | Historial de copiado |

### 💡 Inteligencia (LSP)
| Tecla | Acción |
| :--- | :--- |
| `gd` | Ir a Definición |
| `gr` | Ver Referencias |
| `K`  | Ver documentación |
| `<leader>rn` | Renombrar variable |
| `<leader>ca` | Arreglar errores |
]])
    file:close()
  end
else
  f:close()
end

-- Función para sincronizar configuración con GitHub usando nvsync
local function sync_config()
  print("🚀 Iniciando sincronización con GitHub...")

  -- Ejecutamos nvsync a través de zsh para que reconozca el alias
  -- Usamos vim.fn.jobstart para que no bloquee Neovim mientras sube
  vim.fn.jobstart("zsh -i -c 'nvsync'", {
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then print(line) end
        end
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        print("✅ Sincronización completada con éxito.")
      else
        print("❌ Error en la sincronización. Revisa tu conexión o el repo.")
      end
    end,
  })
end

-- Crear el comando para usarlo como :Sync
vim.api.nvim_create_user_command("Sync", sync_config, {})

-- Atajo de teclado: <leader>gs (Git Sync)
vim.keymap.set("n", "<leader>gs", sync_config, { desc = "Sincronizar config con GitHub" })
