return {
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        'lua_ls',
        'pyright',

        'vtsls',
        'intelephense',
        'html',
        'cssls',
        'emmet_language_server',
        'tailwindcss',
        'astro',
        'svelte',
        'prismals',
      },
    },
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
      },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = {
            'shfmt',
            'stylua',
            'ruff',
            'prettierd',
            'eslint',
            'kdlfmt',
          },
        },
      },
      'neovim/nvim-lspconfig',
      { 'j-hui/fidget.nvim', opts = {} },
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('<K>', vim.lsp.buf.hover, 'Hover documentation')
          map('grn', vim.lsp.buf.rename, 'Rename')
          map('gra', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })
          map('grD', vim.lsp.buf.declaration, 'Go to declaration')
        end,
      })
    end,
  },
}
