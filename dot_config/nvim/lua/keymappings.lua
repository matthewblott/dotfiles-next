-- =============================================================================
-- Key Mappings
-- =============================================================================

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
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
