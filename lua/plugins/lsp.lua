-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- 🔽 TU CONFIGURACIÓN AQUÍ 🔽
    ---@diagnostic disable: missing-fields, deprecated
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

    require("mason").setup()
    require("mason-lspconfig").setup({ ensure_installed = { "gopls" } })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    local servers = { "pyright", "lua_ls", "gopls", "ts_ls", "tsp_server", "html", "cssls", "emmet_ls" }

    for _, server in ipairs(servers) do
      local opts = { capabilities = capabilities }

      if server == "lua_ls" then
        opts.capabilities.textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true
            }
          }
        }
        opts.capabilities.offsetEncoding = {"utf-8"}
        opts.settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        }
      end
      vim.lsp.config(server, opts)
      vim.lsp.enable(server)
    end

    -- Auto-formateo e imports al guardar
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.go", "*.js", "*.jsx", "*.ts", "*.tsx" },
      callback = function()
        -- 1. Organizar imports de forma nativa
        vim.lsp.buf.code_action({
          context = { only = { "source.organizeImports" } },
          apply = true
        })
        -- 2. Formatear el código
        vim.lsp.buf.format({ timeout_ms = 2000 })
      end,
    })
  end,
}
