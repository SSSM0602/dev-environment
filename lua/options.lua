-- Line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true

-- Disables text wrapping 
vim.opt.wrap = false

-- Sync system clipboard with nvim clipboard
vim.opt.clipboard = "unnamedplus"

-- Tab handling
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- Keep cursor in the center while scrolling
vim.opt.scrolloff = 999

-- Select blocks regardless of line length in visual mode 
vim.opt.virtualedit = "block"

-- Split window at bottom to preview changes
vim.opt.inccommand = "split"

-- Ignore case for nvim commands
vim.opt.ignorecase = true

-- Extending colors in nvim
vim.opt.termguicolors = true

vim.opt.autoindent = true
vim.opt.smartindent = true

