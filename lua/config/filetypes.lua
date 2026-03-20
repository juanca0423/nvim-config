-- lua/config/filetypes.lua

-- 1. Registrar extensiones de archivo
vim.filetype.add({
  extension = {
    hbs = "handlebars",
    handlebars = "handlebars",
    pug = "pug",
    jade = "pug",
    jsx = "javascriptreact",
    tsx = "typescriptreact",
  },
  pattern = {
    [".*%.jsx"] = "javascriptreact",
    [".*%.tsx"] = "typescriptreact",
    [".*%.hbs"] = "handlebars",
  },
})

-- 2. Crear aliases de filetypes para Treesitter (incluso si aún no está cargado)
-- Esto evita las advertencias "Unknown filetype"
local function register_treesitter_aliases()
  local ok, _ = pcall(require, "nvim-treesitter.parsers")
  if not ok then
    -- Si treesitter no está listo, reintentar más tarde
    vim.defer_fn(register_treesitter_aliases, 100)
    return
  end

  -- Registrar todos los aliases necesarios
  vim.treesitter.language.register("javascript", "javascriptreact")
  vim.treesitter.language.register("typescript", "typescriptreact")
  vim.treesitter.language.register("tsx", "typescriptreact") -- ← Necesario para TSX
  vim.treesitter.language.register("glimmer", "handlebars")
  vim.treesitter.language.register("pug", "pug")

  -- Registrar los filetypes "puntos" que usan los LSPs
  vim.treesitter.language.register("javascript", "javascript.jsx")
  vim.treesitter.language.register("typescript", "typescript.tsx")

  print("✅ Filetypes registrados correctamente")
end

-- Ejecutar inmediatamente si treesitter ya está cargado, o esperar
register_treesitter_aliases()

-- 3. También registrar cuando se cargue un buffer específico
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascriptreact", "typescriptreact", "handlebars", "pug", "javascript.jsx", "typescript.tsx" },
  callback = function(args)
    -- Asegurar que treesitter se active para estos filetypes
    local ok, _ = pcall(vim.treesitter.start, args.buf)
    if not ok then
      -- Si falla, intentar registrar el alias nuevamente
      pcall(function()
        vim.treesitter.language.register("javascript", "javascriptreact")
        vim.treesitter.language.register("typescript", "typescriptreact")
        vim.treesitter.language.register("glimmer", "handlebars")
        vim.treesitter.language.register("pug", "pug")
      end)
    end
  end,
}

) -- ============================================
-- CONFIGURACIÓN DE DIAGNÓSTICOS
-- ============================================
local icons = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
vim.diagnostic.config({
  virtual_text = { prefix = '●', spacing = 4 },
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
    source = 'always',
    focusable = false,
  },
})
