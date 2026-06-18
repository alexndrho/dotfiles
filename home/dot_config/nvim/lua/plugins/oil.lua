return {
  'malewicz1337/oil-git.nvim',
  dependencies = {
    {
      'stevearc/oil.nvim',
      opts = {},
      dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
      lazy = false,
      keys = {
        { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
      },
    },
  },

  config = true,
}
