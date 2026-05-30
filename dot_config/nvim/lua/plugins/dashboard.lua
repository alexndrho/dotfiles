local string_utils = require 'utils.string'

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    local menu_max_length = 50

    local function menu_item(item)
      local icon = item.icon or ''
      if icon ~= '' then icon = icon .. '  ' end
      return {
        icon = icon,
        desc = string.format('%-' .. menu_max_length .. 's', item.desc),
        key = item.key,
        key_format = '  %s',
        action = item.action,
      }
    end

    local header = {
      [[                                                 ]],
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      [[                                                 ]],
      [[                                                 ]],
    }

    require('dashboard').setup {
      theme = 'doom',
      config = {
        header = header,
        center = {
          menu_item { icon = '', desc = 'Browse files', key = 'e', action = 'Oil' },
          menu_item { icon = '', desc = 'Find file', key = 'f', action = 'Telescope find_files' },
          menu_item { icon = '', desc = 'Find text', key = 't', action = 'Telescope live_grep' },
          menu_item { icon = '', desc = 'Recent files', key = 'r', action = 'Telescope oldfiles' },
          menu_item { icon = '', desc = 'Plugins', key = 'l', action = 'Lazy' },
          menu_item { icon = '', desc = 'Quit', key = 'q', action = 'qa' },
        },
        footer = function()
          if vim.fn.executable 'fortune' == 1 then
            local out = vim.fn.system 'fortune -s'
            return string_utils.wrapText(out, menu_max_length)
          end

          return {}
        end,
        vertical_center = true,
      },
    }
  end,
  dependencies = { { 'nvim-mini/mini.icons' } },
}
