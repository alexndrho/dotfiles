vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    local path = vim.fn.expand '%:p'
    local vaults = vim.fn.expand '~/vaults'

    if path:match('^' .. vim.pesc(vaults)) then vim.opt_local.conceallevel = 2 end
  end,
})
