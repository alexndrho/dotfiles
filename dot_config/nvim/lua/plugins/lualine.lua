local icons = {
  branch = '',
  filename = {
    modified = '●',
    readonly = '',
  },
  diff = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-mini/mini.icons', 'lewis6991/gitsigns.nvim' },
  opts = {
    options = {
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_b = {
        { 'branch', icon = icons.branch },
        {
          'diff',
          colored = true,
          symbols = icons.diff,

          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
        'diagnostics',
      },
      lualine_c = {
        {
          'filename',
          path = 1,
          symbols = icons.filename,
        },
      },

      lualine_x = { 'fileformat', 'filetype' },
    },
    inactive_sections = {
      lualine_c = {
        {
          'filename',
          symbols = icons.filename,
        },
      },
    },
  },
}
