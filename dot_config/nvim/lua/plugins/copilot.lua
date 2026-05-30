return {
  'github/copilot.vim',
  init = function() vim.g.copilot_no_tab_map = true end,
  config = function()
    vim.keymap.set('i', '<C-j>', 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot accept',
    })

    vim.keymap.set('i', '<C-]>', '<Plug>(copilot-dismiss)', { desc = 'Copilot dismiss' })
    vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)', { desc = 'Copilot next suggestion' })
    vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)', { desc = 'Copilot previous suggestion' })
  end,
}
