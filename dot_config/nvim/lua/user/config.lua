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


-- =============================================================================
-- Colour Scheme
-- =============================================================================

-- tmux causes a horrible clash with monokai that needs fixing
-- See https://www.elliottchenstudio.com/blog/neovim-true-color
-- Add the following entries to tmux.conf:
-- set -g default-terminal "xterm-256color"
-- set-option -ga terminal-overrides ",xterm*:Tc"
vim.cmd([[colorscheme monokai-pro]])


-- =============================================================================
-- Key Mappings
-- =============================================================================

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader Key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', 'a', '$A', opts)
keymap('n', 'o', 'o<ESC>', opts)
keymap('n', '<S-o>', 'O<ESC>', opts)

keymap('i', 'kj', '<ESC>', opts)
keymap('n', '<leader>w', '<cmd>write<CR>', opts)

-- Window Navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Indentation
keymap('v', '<Tab>', '>gv', opts)
keymap('v', '<S-Tab>', '<gv', opts)


-- =============================================================================
-- Telescope
-- =============================================================================

local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope.find_files, {})

--vim.keymap.set('n', '<leader>fF', telescope.find_files, { hidden = true, no_ignore = true })
vim.keymap.set('n', '<leader>fF', telescope.find_files, {  })

vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})


-- =============================================================================
-- NVim Tree
-- =============================================================================

-- Disable netrw (recommended when using nvim tree)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function tree_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
  
  vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy node'))
  vim.keymap.set('n', 'n', api.fs.create, opts('New file'))
  vim.keymap.set('n', 'h', api.node.open.tab, opts('Close node'))
  vim.keymap.set('n', 'l', api.node.open.tab, opts('Open node'))
  vim.keymap.set('n', 'm', api.fs.rename_full, opts('Move'))
  vim.keymap.set('n', '<S-p>', api.node.open.preview, opts('Preview'))
end

local tree = require('nvim-tree')

tree.setup({
  -- Although on_attach isn't called here without the line below the keymappings above will not work.
  on_attach = tree_on_attach,
})

local tree_api = require('nvim-tree.api')

vim.keymap.set('n', '<leader>e', tree_api.tree.toggle, {})


-- =============================================================================
-- Barbar
-- =============================================================================

local barbar = require('barbar')

barbar.setup()

vim.keymap.set('n', '<s-l>', '<cmd>BufferNext<cr>', {})
vim.keymap.set('n', '<s-h>', '<cmd>BufferPrevious<cr>', {})
vim.keymap.set('n', '<leader>c', '<cmd>BufferClose<cr>', {})
--vim.keymap.set('n', '<leader>?', '<Cmd>BufferCloseAllButCurrent<CR>', {})


-- =============================================================================
-- Comment 
-- =============================================================================

local comment = require('Comment')

comment.setup()

local comment_api = require('Comment.api')

vim.keymap.set('n', '<leader>/', function() comment_api.toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end, {})
vim.keymap.set('v', '<leader>/', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", {})


-- =============================================================================
-- Smart Splits
-- =============================================================================

local splits = require('smart-splits')

splits.setup()

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<c-left>', splits.resize_left)
vim.keymap.set('n', '<c-down>', splits.resize_down)
vim.keymap.set('n', '<c-up>', splits.resize_up)
vim.keymap.set('n', '<c-right>', splits.resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', splits.move_cursor_left)
vim.keymap.set('n', '<C-j>', splits.move_cursor_down)
vim.keymap.set('n', '<C-k>', splits.move_cursor_up)
vim.keymap.set('n', '<C-l>', splits.move_cursor_right)
vim.keymap.set('n', '<C-\\>', splits.move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', splits.swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', splits.swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', splits.swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', splits.swap_buf_right)


-- =============================================================================
-- Codeium
-- =============================================================================

vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
vim.keymap.set('i', '<c-?>', function() return vim.fn['codeium#Complete']() end, { expr = true, silent = true })


-- =============================================================================
-- Mason
-- =============================================================================

local mason = require('mason')

mason.setup()


-- =============================================================================
-- LSP
-- =============================================================================

-- For lazy loading see:
-- https://lsp-zero.netlify.app/v3.x/guide/lazy-loading-with-lazy-nvim.html


local lsp_zero = require('lsp-zero')

-- Enable keybindings only when you have a language server active in the current file.
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- Setup language servers
local lspconfig = require('lspconfig')

lspconfig.emmet_language_server.setup({})

-- Completions
local cmp = require('cmp')

cmp.setup({
  -- Even if mapping isn't mapped to anything it's still required for
  -- the completions to work.
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    -- ['<C-Space>'] = cmp.mapping.complete(),

  })
})
