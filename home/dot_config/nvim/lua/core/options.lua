vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'nv'
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.showmode = false
vim.o.cursorline = true
vim.o.inccommand = 'split'
vim.o.scrolloff = 10
vim.o.confirm = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.o.updatetime = 250
vim.o.timeoutlen = 1000

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
