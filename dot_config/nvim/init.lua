-- =============================================================================
-- General
-- =============================================================================

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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


-- =============================================================================
-- Key Mappings
-- =============================================================================

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', 'a', '$A', opts)
keymap('n', 'o', 'o<esc>', opts)
keymap('n', '<s-o>', 'O<esc>', opts)

keymap('i', 'kj', '<esc>', opts)
keymap('n', '<leader>w', '<cmd>write<cr>', opts)

-- Window Navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Indentation
keymap('v', '<tab>', '>gv', opts)
keymap('v', '<s-tab>', '<gv', opts)


-- =============================================================================
-- Plugins
-- =============================================================================

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')


-- =============================================================================
-- Colour Scheme
-- =============================================================================

-- tmux causes a horrible clash with monokai that needs fixing
-- See https://www.elliottchenstudio.com/blog/neovim-true-color
-- Add the following entries to tmux.conf:
-- set -g default-terminal "xterm-256color"
-- set-option -ga terminal-overrides ",xterm*:Tc"

vim.cmd('colorscheme monokai-pro')
vim.cmd('set termguicolors')


-- =============================================================================
-- LSP
-- =============================================================================

if pcall(require, 'lsp') then
  require('lsp')
end


-- =============================================================================
-- Configs
-- =============================================================================

require('configs')

