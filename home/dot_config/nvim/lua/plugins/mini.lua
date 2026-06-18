return {
  {
    'nvim-mini/mini.icons',
    opts = {},
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },

  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.surround').setup()
      require('mini.indentscope').setup {
        draw = {
          animation = function() return 0 end,
        },
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'dashboard' },
        callback = function(args) vim.b[args.buf].miniindentscope_disable = true end,
      })
    end,
  },
}
