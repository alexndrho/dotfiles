return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'igorlfs/nvim-dap-view',
        version = '1.*',
        opts = {
          auto_toggle = 'keep_terminal',
        },
      },
      'mason-org/mason.nvim',
      {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
          automatic_installation = true,
          ensure_installed = { 'js' },
          handlers = {
            function(config) require('mason-nvim-dap').default_setup(config) end,

            js = function(config)
              local dap = require 'dap'

              local js_debug_adapter = {
                type = 'server',
                host = 'localhost',
                port = '${port}',
                executable = {
                  command = vim.fn.exepath 'js-debug-adapter',
                  args = { '${port}' },
                },
              }

              dap.adapters['pwa-node'] = js_debug_adapter
              dap.adapters['pwa-chrome'] = js_debug_adapter

              for _, language in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } do
                dap.configurations[language] = {
                  {
                    type = 'pwa-node',
                    request = 'launch',
                    name = 'Node: Launch current file',
                    program = '${file}',
                    cwd = '${workspaceFolder}',
                    runtimeExecutable = 'node',
                    console = 'integratedTerminal',
                  },
                  {
                    type = 'pwa-node',
                    request = 'attach',
                    name = 'Node: Attach to process',
                    processId = require('dap.utils').pick_process,
                    cwd = '${workspaceFolder}',
                  },
                  {
                    type = 'pwa-chrome',
                    request = 'launch',
                    name = 'Chrome: Launch localhost',
                    url = 'http://localhost:3000',
                    webRoot = '${workspaceFolder}',
                  },
                }
              end

              require('mason-nvim-dap').default_setup(config)
            end,
          },
        },
      },
    },
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
      { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
      { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
      { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
      { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
      { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
      { '<F7>', function() require('dap-view').toggle(true) end, desc = 'Debug: Toggle DAP view' },
    },
    config = function()
      local breakpoint_icons = { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }

      for type, icon in pairs(breakpoint_icons) do
        local tp = 'Dap' .. type
        local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
        vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
}
