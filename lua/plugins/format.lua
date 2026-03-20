return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- Se activa justo antes de guardar
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Go: usa gofmt (estándar) o goimports si lo tienes instalado
      go = { "gofmt", "goimports" },
      -- Web: usamos prettier para que el .hbs y .js se vean limpios
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      handlebars = { "prettier" },
      css = { "prettier" },
    },
    -- Formatear al guardar automáticamente
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
