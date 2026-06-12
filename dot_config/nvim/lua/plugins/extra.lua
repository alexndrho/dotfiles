return {
  {
    'vyfor/cord.nvim',
    opts = {
      display = {
        theme = 'minecraft',
      },
      text = {
        editing = function(opts) return 'Ruining ' .. opts.filename end,
        viewing = function(opts) return 'Staring at ' .. opts.filename end,
        workspace = function(opts) return 'Lost in ' .. opts.workspace end,
        terminal = 'rm -rf (jk... maybe)',
        file_browser = 'Lost in the files',
        plugin_manager = "Another plugin won't hurt",
        vcs = 'Looking for someone to blame',
        docs = "Reading docs I won't remember",
      },
      idle = {
        state = 'Peak procrastination',
        details = 'The cursor blinks. I do not.',
        tooltip = '💀',
      },
      buttons = {
        {
          label = function(opts) return opts.repo_url and 'View Repository' or 'Website' end,
          url = function(opts) return opts.repo_url or 'https://www.alexanderho.dev/' end,
        },
      },
    },
  },
}
