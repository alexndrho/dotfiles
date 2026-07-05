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
        { '<leader>o', group = 'Obsidian', icon = '', mode = { 'n', 'v' } },
        { '<leader>os', group = 'Sort', mode = { 'v' } },
        { '<leader>q', group = 'Quit/Session' },
        { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
        { '<leader>t', group = 'Toggle' },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },

  {
    'vyfor/cord.nvim',
    opts = {
      display = {
        theme = 'minecraft',
      },
      idle = {
        state = 'Peak procrastination',
        details = 'The cursor blinks. I do not.',
        tooltip = '💀',
      },
      buttons = {
        {
          label = 'View Repository',
          url = function(opts) return opts.repo_url end,
        },
      },
    },
  },
}
