-- =============================================================================
-- General
-- =============================================================================

-- Added for the file preview window because updating is too slow to load
vim.opt.updatetime = 100

-- Make line numbers default

-- window options
vim.wo.number = true
vim.wo.relativenumber = true

-- Options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Don't wrap lines by default
vim.opt.wrap = false
