
-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    ---@diagnostic disable: missing-fields, deprecated
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "gopls" }
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    vim.lsp.config.default_config = {
      capabilities = capabilities
    }
    local servers = { "pyright", "lua_ls", "gopls", "ts_ls", "html", "cssls", "emmet_language_server","sql" }

    for _, server in ipairs(servers) do
      local opts = { capabilities = capabilities }

-- En tu bucle for _, server in ipairs(servers) do
      if server == "html" or server == "emmet_language_server" then
        opts.filetypes = { "html", "handlebars", "hbs" }
      end
      -- Configuración para Go
      if server == "gopls" then
        opts.settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
          },
        }
      end

      -- Configuración para JS/TS
      if server == "ts_ls" then
        opts.settings = {
          javascript = { suggest = { autoImports = true } },
          typescript = { suggest = { autoImports = true } },
        }
      end

      -- Configuración para Lua
      if server == "lua_ls" then
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

      -- ESTILO NEVIM 0.11 (Sin el error de deprecated)
      vim.lsp.config(server, opts)
      vim.lsp.enable(server)
    end

    -- Auto-formateo e imports al guardar
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.go", "*.js", "*.jsx", "*.ts", "*.tsx" ,"sql"},
      callback = function()
        local ft = vim.bo.filetype
        if ft == "go" then
          local ok, go_fmt = pcall(require, 'go.format')
          if ok then go_fmt.goimports() else vim.lsp.buf.format() end
        else
          -- JS/TS Organize Imports
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" } },
            apply = true
          })
          vim.lsp.buf.format({ timeout_ms = 2000 })
        end
      end,
    })
  end,
}
