return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  dependencies = { 'saghen/blink.cmp' },
  opts = {
    preview = {
      icon_provider = 'mini',
    },
  },
  keys = {
    { '<leader>tm', '<cmd>Markview toggle<cr>', desc = 'Toggle MarkView' },
    { '<leader>tM', '<cmd>Markview Toggle<cr>', desc = 'Toggle Markview (global)' },
    { '<leader>ts', '<cmd>Markview splitToggle<cr>', desc = 'Toggle MarkView (split)' },
  },
}
