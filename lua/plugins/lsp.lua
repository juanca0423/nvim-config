-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/lazydev.nvim",
    { "bilal2453/luvit-meta", lazy = true },
  },
  config = function()
    -- --- 0. REGISTRO DE TIPOS DE ARCHIVO (Limpia los Warnings del checkhealth) ---
    -- Esto le dice a Neovim que "hbs" y "handlebars" son nombres válidos.
    vim.filetype.add({
      extension = {
        hbs = 'handlebars',
        handlebars = 'handlebars',
        gowork = 'gowork',
        gotmpl = 'gotmpl',
      },
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
      -- Quitamos lua_ls de aquí para usar el de 'pkg' de Termux
      ensure_installed = { "gopls", "pyright", "ts_ls" }
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Servidores a configurar
    local servers = { "pyright", "lua_ls", "gopls", "ts_ls", "html", "cssls", "emmet_language_server", "sqls" }

    for _, server in ipairs(servers) do
      local opts = { capabilities = capabilities }

      -- Personalizaciones por servidor
      if server == "lua_ls" then
        opts.settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            completion = { callSnippet = "Replace" }
          }
        }
      end

      if server == "gopls" then
        opts.filetypes = { "go", "gomod", "gowork", "gotmpl" }
      end

      -- NUEVA FORMA (Neovim 0.11+)
      -- 1. Configuramos el servidor
      vim.lsp.config(server, opts)
      -- 2. Lo habilitamos
      vim.lsp.enable(server)
    end
    -- --- LÓGICA DE FORMATEO (Mantenemos tu lógica unificada) ---
    local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormatGroup", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_fmt_group,
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

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
                  if r.edit then vim.lsp.util.apply_workspace_edit(r.edit, "utf-8") end
                end
              end
            elseif ft == "javascript" or ft == "typescript" or ft == "typescriptreact" then
              pcall(function()
                vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
              end)
            end

            -- Formateo
            if client and client.supports_method("textDocument/formatting") then
              vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
            end
          end,
        })
      end,
    })
  end,
}
