-- Theme
local theme = { 
  'loctvl842/monokai-pro.nvim',
}

local telescope = {}

if not vim.g.vscode then
  telescope = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  }
end

local fzf = {}

if not vim.g.vscode then
  fzf = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make' 
  }
end

local tmux = {}

if not vim.g.vscode then
  tmux = {
    'camgraff/telescope-tmux.nvim',
    lazy = false,
    dependencies = {
      'norcalli/nvim-terminal.lua',
    },
  }
end

local treesitter = {}

if not vim.g.vscode then
  treesitter = {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  }
end

local fileExplorer = {}

if not vim.g.vscode then
  fileExplorer = {
    -- File explorer
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'b0o/nvim-tree-preview.lua',
    },
  }
end

local barbar = {}

-- Working with tabs
if not vim.g.vscode then
  barbar = {
    'romgrk/barbar.nvim',
  }
end

local smartSplits = {}

-- Make sure the christoomey/vim-tmux-navigator
-- plugin is installed and the keymappings are set
if not vim.g.vscode then
  smartSplits = { 
    'mrjones2014/smart-splits.nvim' 
  }
end

local comments = {}

if not vim.g.vscode then
  comments = {
    'numToStr/Comment.nvim',
    lazy = false,
  }
end

local pencil = {}

-- For working with text
if not vim.g.vscode then
  pencil = {
    'preservim/vim-pencil',
  }
end

local autopairs = {}

if not vim.g.vscode then
  autopairs = {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true
  }
end

local mason = {}

if not vim.g.vscode then
  mason = {'williamboman/mason.nvim'}
end

local masonLsp = {}

if not vim.g.vscode then
  masonLsp = {'williamboman/mason-lspconfig.nvim'}
end

local lspZero = {}

if not vim.g.vscode then
  lspZero = {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'}
end

local lspConfig = {}

if not vim.g.vscode then
  lspConfig = {'neovim/nvim-lspconfig'}
end

local cmpLsp = {}

if not vim.g.vscode then
  cmpLsp = {'hrsh7th/cmp-nvim-lsp'}
end

local cmp = {}

if not vim.g.vscode then
  cmp = {'hrsh7th/nvim-cmp'}
end

local luaSnip = {}

if not vim.g.vscode then
  luaSnip = {'L3MON4D3/LuaSnip'}
end

local codeium = {}

if not vim.g.vscode then
  codeium = {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  }
end

local gp = {}

if not vim.g.vscode then
  gp = {
    'robitx/gp.nvim',
  }
end

return {
  theme, 
  telescope, 
  fzf, 
  tmux,
  treesitter,
  fileExplorer,
  barbar,
  smartSplits,
  comments,
  pencil,
  autopairs,
  mason,
  masonLsp,
  lspZero,
  lspConfig,
  cmpLsp, 
  cmp,
  luaSnip,
  codeium,
  gp,
}
