
local function conf()
  local dap = require("dap")
--  dap.adapters.node2 = {
  --  type = 'server',
    --command = 'node',
  --  args = {vim.fn.expand('$HOME/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js')},
  --}
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
      }
    }
  })
  vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='', numhl=''})
      -- Esto abre la interfaz automáticamente al empezar
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
  dapui.open()
  end
      -- Esto la cierra al terminar (opcional, puedes comentarlo si prefieres ver los resultados)
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end


return{
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },
  config=conf
}


