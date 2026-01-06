---@diagnostic disable: missing-fields, deprecated
---
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"gopls"},
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
--require('lspconfig').emmet_ls.setup({
--    capabilities = capabilities, -- 🔌 Conecta el LSP con nvim-cmp
--})
local servers = { "pyright", "lua_ls", "gopls", "ts_ls","tsp_server", "html", "cssls", "emmet_ls" }

for _, server in ipairs(servers) do
  local opts = {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  }
-- 2. Personalizamos si el servidor es lua_ls
  if server == "lua_ls" then
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }, -- Adiós a las "W" en el margen 🛡️
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    }
  end
-- 3. Aplicamos la nueva API nativa
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end

local function go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params(0, "utf-8")
  params.context = {
    only = {"source.organizeImports"},
    diagnostics={},
  }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
      else
        vim.lsp.buf.execute_command(r)
      end
    end
  end
end

-- 2. Creamos el comando que se activa al guardar (*.go)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.go", "*.js", "*.jsx", "*.ts", "*.tsx"},
  callback = function()
    local params = vim.lsp.util.make_range_params(0, "utf-8")
    params.context = {only = {"source organizeImports"}, diagnostics={}}
    vim.lsp.buf_request_sync(0, "textDocument/codeAction", params,1000)
    vim.lsp.buf.format({timeout_ms = 1000})       -- Arregla el espaciado/sintaxis 📐
  end,
})


