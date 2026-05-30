return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,

      spec = {
        { '<leader>b', group = 'Buffer' },
        { '<leader>g', group = 'Git' },
        { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
        { '<leader>q', group = 'Quit/Session' },
        { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
        { '<leader>t', group = 'Toggle' },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },
}
