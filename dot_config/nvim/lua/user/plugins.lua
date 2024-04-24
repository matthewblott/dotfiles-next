local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
    build = ':TSUpdate',
  },
  {
    -- File explorer
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    -- Theme
    'loctvl842/monokai-pro.nvim',
  },
  {
    -- Working with tabs
    'romgrk/barbar.nvim',
  },
  { 
    -- Make sure the christoomey/vim-tmux-navigator
    -- plugin is installed and the keymappings are set
    'mrjones2014/smart-splits.nvim' 
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
  },
  {
    -- For working with text
    'preservim/vim-pencil',
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  },
}) 
