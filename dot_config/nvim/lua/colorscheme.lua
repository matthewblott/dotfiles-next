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
