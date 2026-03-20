-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/lazydev.nvim",
    { "bilal2453/luvit-meta", lazy = true },
  },
  config = function()
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
      ensure_installed = { "gopls", "pyright", "ts_ls" }
    })

    -- Solo una asignación de capabilities
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Servidores a configurar
    local servers = { "pyright", "lua_ls", "gopls", "ts_ls", "html", "cssls", "emmet_language_server", "sqls" }

    for _, server in ipairs(servers) do
      local opts = { capabilities = capabilities }

      -- ============================================
      -- TYPESCRIPT / JAVASCRIPT (ts_ls)
      -- ============================================
      if server == "ts_ls" then
        opts.filetypes = { -- ← opts.filetypes, no capabilities
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx"
        }
        opts.settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayVariableTypeHints = true,
            },
          },
        }
      end

      -- ============================================
      -- HTML + PUG + HANDLEBARS
      -- ============================================
      if server == "html" then -- ← server, no servers
        opts.filetypes = { "html", "templ", "pug", "handlebars" }
      end                      -- ← sin coma aquí

      -- Emmet para expansión de código HTML/CSS
      if server == "emmet_language_server" then
        opts.filetypes = {
          "html", "css", "scss",
          "pug", "handlebars",
          "javascriptreact", "typescriptreact"
        }
      end -- ← faltaba este end

      -- ============================================
      -- CSS
      -- ============================================
      -- cssls no necesita configuración especial, usa opts por defecto
      if server == "cssls" then
        -- opts por defecto está bien
      end

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

      vim.lsp.config(server, opts)
      vim.lsp.enable(server)
    end

    -- ============================================
    -- AUTOCOMMANDS DE FORMATO Y KEYMAPS
    -- ============================================
    local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormatGroup", { clear = true })
    local lsp_keymap_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

    -- Formato al guardar
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

    -- ============================================
    -- KEYMAPS DE LSP
    -- ============================================
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_keymap_group,
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Navegación
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

        -- Documentación
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        -- Acciones
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })
  end,
}
