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
      format_on_save = function(bufnr)
        if vim.b[bufnr].disable_format_on_save then return nil end

        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
      formatters_by_ft = {
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },

        lua = { 'stylua' },
        python = { 'ruff_format' },

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
        jsonc = { 'prettierd' },
        yaml = { 'prettierd' },

        markdown = { 'prettierd' },
        ['markdown.mdx'] = { 'prettierd' },

        graphql = { 'prettierd' },

        kdl = { 'kdlfmt' },
      },
    },
  },
}
