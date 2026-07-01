return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'personal',
        path = '~/vaults/personal',
      },
    },
    ---@diagnostic disable-next-line: missing-fields
    ui = {
      enable = false,
    },
    templates = {
      folder = 'templates',
      date_format = '%A, %B %d, %Y',
      time_format = '%I:%M %p',
      substitutions = {
        daily_date = function(ctx)
          local id = ctx.partial_note.id
          local year, month, day = id:match '(%d+)%-(%d+)%-(%d+)'
          if not (year and month and day) then return id end

          return tostring(os.date(
            '%A, %B %-d, %Y',
            os.time {
              year = year,
              month = month,
              day = day,
            }
          ))
        end,
      },
    },
    daily_notes = {
      enabled = true,
      folder = 'daily',
      date_format = '%Y-%m-%d',
      default_tags = { 'daily' },
      template = 'templates/daily_template.md',
    },
    picker = {
      name = 'telescope.nvim',
    },
    checkbox = {
      order = { ' ', 'x', '~', '!', '>' },
    },
    callbacks = {
      enter_note = function()
        vim.b.disable_format_on_save = true

        -- normal mode
        vim.keymap.set('n', '<leader>oo', '<cmd>Obsidian<cr>', { buffer = true, desc = 'Open Obsidian' })
        vim.keymap.set('n', '<leader>tc', '<cmd>Obsidian toggle_checkbox<cr>', {
          buffer = true,
          desc = 'Toggle checkbox',
        })

        -- visual mode
        vim.keymap.set('v', '<leader>osc', [[:'<,'>sort i /^\s*[-*+]\s\[.\]\s*/<cr>]], { buffer = true, desc = 'Sort checkboxes items by text' })
      end,
    },
  },
}
