return {
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format {
            async = true,
            lsp_format = 'fallback',
          }
        end,
        mode = { 'n', 'v' },
        desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        vue = { 'prettierd' },
        svelte = { 'prettierd' },
        astro = { 'prettierd' },
        html = { 'prettierd' },
        css = { 'prettierd' },
        scss = { 'prettierd' },
        less = { 'prettierd' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
        markdown = { 'prettierd' },
        graphql = { 'prettierd' },
      },
    },
  },
}
