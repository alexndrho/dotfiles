return {
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true

      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('colorscheme-highlights', { clear = true }),
        pattern = 'gruvbox-material',
        callback = function()
          local config = vim.fn['gruvbox_material#get_configuration']()
          local palette = vim.fn['gruvbox_material#get_palette'](config.background, config.foreground, config.colors_override)
          local set_hl = vim.fn['gruvbox_material#highlight']

          set_hl('OilGitAdded', palette.green, palette.none)
          set_hl('OilGitModified', palette.yellow, palette.none)
          set_hl('OilGitModifiedStaged', palette.yellow, palette.none)
          set_hl('OilGitModifiedUnstaged', palette.orange, palette.none)
          set_hl('OilGitRenamed', palette.purple, palette.none)
          set_hl('OilGitDeleted', palette.red, palette.none)
          set_hl('OilGitCopied', palette.purple, palette.none)
          set_hl('OilGitConflict', palette.orange, palette.none)
          set_hl('OilGitUntracked', palette.blue, palette.none)
          set_hl('OilGitIgnored', palette.grey0, palette.none)
        end,
      })

      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
}
