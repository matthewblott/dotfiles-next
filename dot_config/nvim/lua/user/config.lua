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

local telescope = require('telescope')

telescope.setup()
telescope.load_extension('fzf')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fF', '', { callback = function() builtin.find_files({ hidden = true, no_ignore = true }) end, desc = "Find files" })
vim.keymap.set('n', '<leader>fw', builtin .live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin .buffers, {})
vim.keymap.set('n', '<leader>fh', builtin .help_tags, {})


-- =============================================================================
-- NVim Tree
-- =============================================================================

-- Disable netrw (recommended when using nvim tree)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local preview = require('nvim-tree-preview')

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
  vim.keymap.set('n', '<s-p>', api.node.open.preview, opts('Preview'))

  -- nvim-tree-preview
  vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
  vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
  vim.keymap.set('n', '<Tab>', function()
    local ok, node = pcall(api.tree.get_node_under_cursor)
    if ok and node then
      if node.type == 'directory' then
        api.node.open.edit()
      else
        preview.node(node, { toggle_focus = true })
      end
    end
  end, opts 'Preview')

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
vim.keymap.set('n', '<leader>v', '<cmd>BufferCloseAllButCurrent<cr>', {})


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
vim.keymap.set('n', '<c-h>', splits.move_cursor_left)
vim.keymap.set('n', '<c-j>', splits.move_cursor_down)
vim.keymap.set('n', '<c-k>', splits.move_cursor_up)
vim.keymap.set('n', '<c-l>', splits.move_cursor_right)
vim.keymap.set('n', '<c-\\>', splits.move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', splits.swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', splits.swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', splits.swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', splits.swap_buf_right)


-- =============================================================================
-- Codeium
-- =============================================================================

-- N.B. when running Codeium Auth make sure you are running in tmux,
-- the token won't be parsed properly otherwise and you'll receive an error.

vim.keymap.set('i', '<c-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
vim.keymap.set('i', '<c-k>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
vim.keymap.set('i', '<c-j>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
vim.keymap.set('i', '<c-l>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
vim.keymap.set('i', '<c-h>', function() return vim.fn['codeium#Complete']() end, { expr = true, silent = true })

-- Disable for certain file types
vim.g.codeium_filetypes = {
  markdown = false,
}


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

-- Emmet
lspconfig.emmet_language_server.setup({})

-- Kotlin
lspconfig.kotlin_language_server.setup({})

-- TypeScript
lspconfig.tsserver.setup({})

--------------------------------------------------------------------------------------
-- Start Ruby
--------------------------------------------------------------------------------------

-- textDocument/diagnostic support until 0.10.0 is released
_timers = {}
local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end

  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)
    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
        vim.lsp.log.error(err_msg)
      end
      local diagnostic_items = {}
      if result then
        diagnostic_items = result.items
      end
      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
        { client_id = client.id }
      )
    end)
  end

  diagnostic_handler() -- to request diagnostics on buffer when first attaching

  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
    end,
    on_detach = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
    end,
  })
end

-- adds ShowRubyDeps command to show dependencies in the quickfix list.
-- add the `all` argument to show indirect dependencies as well
local function add_ruby_deps_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps",
                                        function(opts)

    local params = vim.lsp.util.make_text_document_params()
    local showAll = opts.args == "all"

    client.request("rubyLsp/workspace/dependencies", params,
                    function(error, result)
        if error then
            print("Error showing deps: " .. error)
            return
        end

        local qf_list = {}
        for _, item in ipairs(result) do
            if showAll or item.dependency then
                table.insert(qf_list, {
                    text = string.format("%s (%s) - %s",
                                          item.name,
                                          item.version,
                                          item.dependency),

                    filename = item.path
                })
            end
        end

        vim.fn.setqflist(qf_list)
        vim.cmd('copen')
    end, bufnr)
  end, {nargs = "?", complete = function()
    return {"all"}
  end})
end

lspconfig.ruby_lsp.setup({
  on_attach = function(client, buffer)
    setup_diagnostics(client, buffer)
    add_ruby_deps_command(client, buffer)
  end,
})

-- adds ShowRubyDeps command to show dependencies in the quickfix list.
-- add the `all` argument to show indirect dependencies as well
local function add_ruby_deps_command(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps",
                                          function(opts)

        local params = vim.lsp.util.make_text_document_params()

        local showAll = opts.args == "all"

        client.request("rubyLsp/workspace/dependencies", params,
                        function(error, result)
            if error then
                print("Error showing deps: " .. error)
                return
            end

            local qf_list = {}
            for _, item in ipairs(result) do
                if showAll or item.dependency then
                    table.insert(qf_list, {
                        text = string.format("%s (%s) - %s",
                                              item.name,
                                              item.version,
                                              item.dependency),

                        filename = item.path
                    })
                end
            end

            vim.fn.setqflist(qf_list)
            vim.cmd('copen')
        end, bufnr)
    end, {nargs = "?", complete = function()
        return {"all"}
    end})
end

require("lspconfig").ruby_lsp.setup({
  on_attach = function(client, buffer)
    setup_diagnostics(client, buffer)
    add_ruby_deps_command(client, buffer)
  end,
})

--------------------------------------------------------------------------------------
-- End Ruby
--------------------------------------------------------------------------------------

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
