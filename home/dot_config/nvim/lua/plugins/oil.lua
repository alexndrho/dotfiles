return {
  'malewicz1337/oil-git.nvim',
  dependencies = {
    {
      'stevearc/oil.nvim',
      opts = {
        delete_to_trash = true,
      },
      dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
      lazy = false,
      keys = {
        { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
      },
    },
  },

  config = true,
}
