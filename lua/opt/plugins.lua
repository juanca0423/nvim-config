return {
-- 3. Treesitter: Resaltado de sintaxis inteligente 🌳
  {
    "nvim-treesitter/nvim-treesitter",
    lazy=false,
    build = ":TSUpdate",
    Config = function()
      require("config.treesitter")
    end
  },
  -- 1. Colores para que Termux se vea increíble 🎨
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Cargar antes que lo demás
    config = function()
    require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        term_colors = true, -- Esto ayuda a que los colores resalten más en terminal
        integrations={
          bufferline=true,
        }
      })
      vim.cmd.colorscheme "catppuccin"
    end
  },
  -- 2. Telescope: Tu nuevo buscador supersónico 🔭
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
      require("config.telescope")
    end
  },
  -- Extensión 1: FZF Native para velocidad máxima ⚡
  {
    'nvim-telescope/telescope-fzf-native.nvim',
     build = 'make'
  },
    -- Extensión 2: UI-Select para menús bonitos 🎨
  {
    'nvim-telescope/telescope-ui-select.nvim'
  },
    -- LSP: El motor de inteligencia 🧠
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
    -- Autocompletado ⌨️
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Fuente para el LSP
      "hrsh7th/cmp-path",     -- Fuente para rutas de archivos
      "L3MON4D3/LuaSnip",     -- Motor de snippets (necesario)
      "saadparwaiz1/cmp_luasnip",
    },
  },
  { "lspkind.nvim",},
  { 'onsails/lspkind.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  {
    "nvim-tree/nvim-tree.lua",
     version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
      actions={
        open_file={
          quit_on_open=true
        },
      },
    })
  end,
  },
  {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'catppuccin',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          { 'filename', file_status = true, path = 1}
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = '󰌵 ',
            },
            diagnostics_color = {
              error = {fg = '#f38ba8'},
              warn = {fg = '#f9e2af'},
            }
          },
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    })
  end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Recomendado para tener las últimas funciones
    build = "make install_jsregexp" -- Opcional: para soporte de regex avanzado
  },
  {
    "rafamadriz/friendly-snippets",
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true -- Esto ejecuta la configuración básica automáticamente
  },
  {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = true
  },
  {
  "gbprod/yanky.nvim",
  config = function()
    require("yanky").setup({})
    -- Atajos sugeridos
    vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleForward)") -- Ciclar entre lo copiado
    vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleBackward)")
  end
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('neogen').setup({
        enabled = true,
          languages = {
            javascript = {
              template = {
                annotation_convention = "jsdoc"
              }
            },
            typescript = {
              template = {
                annotation_convention = "tsdoc"
              }
            },
                -- También funciona para Go
            go =  {
              template = {
                annotation_convention = "godoc"
              }
            }
          }
      })
   end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant", -- Estilo de las pestañas ( "thin" o "thick")
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
      }
    }
  },
  {
    "mfussenegger/nvim-dap",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
      "nvim-neotest/nvim-nio",
    },
    -- Dentro de la configuracion de nvim-dap en plugins.lua
    config = function()
      local dap = require("dap")
      -- Configuración para Node.js usando el adaptador de Mason
      dap.adapters.node2 = {
        type = 'server',
        command = 'node',
 -- Mason instala los binarios en esta ruta en Termux:
        args = {vim.fn.expand('$HOME/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js')},
      }
      dap.adapters["pwa-node"] = {
        type = 'server',
        host = '127.0.0.1',
        port = '${port}',
        executable = {
          command = 'node',
  -- Ruta al binario que crea Mason
          args = {
            vim.fn.expand('$HOME/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'),
            '${port}',
          },
        },
      }
      dap.configurations.javascript={
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Lanzar Node.js (Moderno)',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
      }
      dap.configurations.typescript=dap.configurations.javascript
      local dapui = require("dapui")
      dapui.setup()
      require('dap-go').setup({
        delve = {
          path = "/data/data/com.termux/files/home/go/bin/dlv",
          initialize_timeout_sec = 50,
        },
        dap_configurations = {
          {
            type = "go",
            name = "Debug",
            request = "launch",
            program = "${file}",
            build_flags = "-gcflags='all=-N -l'",
          },
        },
      })
      vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='', numhl=''})
      -- Esto abre la interfaz automáticamente al empezar
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      -- Esto la cierra al terminar (opcional, puedes comentarlo si prefieres ver los resultados)
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
  -- Opciones recomendadas para UFO
      vim.o.foldcolumn = '1' -- '0' si no quieres ver la columna de plegado
      vim.o.foldlevel = 99 -- Empieza con todo desplegado
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      require('ufo').setup()
    end
  },
  {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      current_line_blame = true, -- Muestra quién hizo el cambio en la línea actual
    })
  end
},
{
  'mistweaverco/kulala.nvim',
  config = function()
    require('kulala').setup({})
  end
},
{
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
  },
  config = function()
    vim.g.neotest_root = vim.fn.getcwd()
    require("neotest").setup({
      adapters = {
        require("neotest-go")({
           --recursive = true,
           experimental_fast_directories = false, -- Desactivar esto ayuda en Termux
           --go_test_args = {"-v", "-race", "-count=1"},
           --show_test_output=true,
        })
      },{
        discovery={
          enabled=true,
          filter_dir = function(name)
            return name ~= "vendor"
          end,
        }
      },
        status = { enabled = true, signs = true },
        icons = { passed = "P", failed = "X", running = "R" },
        diagnostic = { enabled = true },
      -- status = { signs = true, virtual_text = true },
        floating={
          border = "rounded",
          max_height = 0.8,
          max_width = 0.9,
          options = {}
        },
        strategies={
          integrated={
            width=120
          }
        },
      })
    end
  }
}

