-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/lazydev.nvim",
    { "bilal2453/luvit-meta", lazy = true }, -- Muy importante para que el linter entienda vim.uv
  },
  config = function()
    -- 1. Setup básico de Mason y Lazydev
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "gopls" }
    })

    -- Configuración correcta de lazydev
    require("lazydev").setup({
      library = {
        -- Carga los tipos de la API de Neovim y el plugin de tipos luvit
        { path = "luvit-meta/library", words = { "vim%.uv", "vim%.loop" } },
      },
    })

    -- 2. Capacidades para el autocompletado
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- 3. Definición de servidores
    local servers = { "pyright", "lua_ls", "gopls", "ts_ls", "html", "cssls", "emmet_language_server", "sql" }

    for _, server in ipairs(servers) do
      local opts = { capabilities = capabilities }

      if server == "html" or server == "emmet_language_server" then
        opts.filetypes = { "html", "handlebars", "hbs" }
      end

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

      if server == "lua_ls" then
        opts.settings = {
          Lua = { completion = { callSnippet = "Replace" } },
        }
      end

      -- Configurar y activar (Estilo NVIM 0.11)
      vim.lsp.config(server, opts)
      vim.lsp.enable(server)
    end

    -- 4. Lógica de formateo y Organize Imports (Unificada)
    local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormatGroup", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_fmt_group,
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Evitamos duplicar autocomandos al re-adjuntar el LSP
        vim.api.nvim_clear_autocmds({ group = lsp_fmt_group, buffer = bufnr })

        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          group = lsp_fmt_group,
          callback = function()
            local ft = vim.bo[bufnr].filetype

            -- Organizar Imports
            if ft == "go" then
              local params = vim.lsp.util.make_range_params()
              params.context = { only = { "source.organizeImports" } }
              local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
              for _, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                  if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
                  end
                end
              end
            elseif ft == "javascript" or ft == "typescript" or ft == "typescriptreact" then
              pcall(function()
                vim.lsp.buf.code_action({
                  context = { only = { "source.organizeImports" } },
                  apply = true,
                })
              end)
            end

            -- Formateo General
            if client and client.supports_method("textDocument/formatting") then
              vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
            end
          end,
        })
      end,
    })
  end,
}
