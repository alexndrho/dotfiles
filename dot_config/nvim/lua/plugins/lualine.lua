local filename_symbols = {
  modified = '●',
  readonly = '',
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
        { 'branch', icon = '' },
        {
          'diff',
          colored = true,
          symbols = { added = '+', modified = '~', removed = '-' },

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
          symbols = filename_symbols,
        },
      },

      lualine_x = { 'fileformat', 'filetype' },
    },
    inactive_sections = {
      lualine_c = {
        {
          'filename',
          symbols = filename_symbols,
        },
      },
    },
  },
}
