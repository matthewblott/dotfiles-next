-- =============================================================================
-- Telescope
-- =============================================================================

if pcall(require, 'telescope') then

  local telescope = require('telescope')

  telescope.setup()
  telescope.load_extension('fzf')

  local builtin = require('telescope.builtin')

  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fF', '', { callback = function() builtin.find_files({ hidden = true, no_ignore = true }) end, desc = "Find files" })
  vim.keymap.set('n', '<leader>fw', builtin .live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin .buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin .help_tags, {})

end


-- =============================================================================
-- NVim Tree
-- =============================================================================

if pcall(require, 'nvim-tree-preview') then

  -- Disable netrw (recommended when using nvim tree)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  local preview = require('nvim-tree-preview')

  local function tree_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local function toggle_node_if_directory()
      local current_node = api.tree.get_node_under_cursor()
      -- local node = api.tree.get_node_under_cursor()
      if current_node.type == 'directory' then
        api.node.open.tab()
      end
    end

    local function handle_node()
      local current_node = api.tree.get_node_under_cursor()
      -- if not current_node then
      --   print("No node selected")
      --   return
      -- end

      -- Get the full path of the selected node
      local node_path = current_node.absolute_path

      -- Execute the bash script with the node path as an argument
      local cmd = string.format("bash ${HOME}/.local/bin/del '%s'", node_path)
      os.execute(cmd)
    end


    -- default mappings
    api.config.mappings.default_on_attach(bufnr)
    
    vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy node'))
    vim.keymap.set('n', 'n', api.fs.create, opts('New file'))

    vim.keymap.set('n', 'd', handle_node, opts('Delete file'))


    vim.keymap.set('n', 'h', toggle_node_if_directory, opts('Close node'))
    vim.keymap.set('n', 'l', toggle_node_if_directory, opts('Open node'))
    vim.keymap.set('n', 'm', api.fs.rename_full, opts('Move'))
    vim.keymap.set('n', '<s-p>', api.node.open.preview, opts('Preview'))

    -- nvim-tree-preview
    vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
    vim.keymap.set('n', '<esc>', preview.unwatch, opts 'Close Preview/Unwatch')
    vim.keymap.set('n', '<tab>', function()
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
    actions = {
      open_file = {
        resize_window = false, -- Prevent the window from resizing when opening a file
      },
    },
  })

  local tree_api = require('nvim-tree.api')

  vim.keymap.set('n', '<leader>e', tree_api.tree.toggle, {})

end


-- =============================================================================
-- Barbar
-- =============================================================================

if pcall(require, 'barbar') then

  local barbar = require('barbar')

  barbar.setup()

  vim.keymap.set('n', '<s-l>', '<cmd>BufferNext<cr>', {})
  vim.keymap.set('n', '<s-h>', '<cmd>BufferPrevious<cr>', {})
  vim.keymap.set('n', '<leader>c', '<cmd>BufferClose<cr>', {})
  vim.keymap.set('n', '<leader>v', '<cmd>BufferCloseAllButCurrent<cr>', {})

end


-- =============================================================================
-- Comment 
-- =============================================================================

if pcall(require, 'Comment') then

  local comment = require('Comment')

  comment.setup()

  local comment_api = require('Comment.api')

  vim.keymap.set('n', '<leader>/', function() comment_api.toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end, {})
  vim.keymap.set('v', '<leader>/', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", {})

end


-- =============================================================================
-- Smart Splits
-- =============================================================================

if pcall(require, 'smart-splits') then

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

end


-- =============================================================================
-- Pencil
-- =============================================================================

if vim.fn.exists(":Pencil") == 2 then
  vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"markdown", "text"},
    callback = function()
      vim.cmd("PencilSoft")
    end
  })
end


-- =============================================================================
-- Mason
-- =============================================================================

if pcall(require, 'mason') then

  local mason = require('mason')

  mason.setup({
  })

end


-- =============================================================================
-- LSP
-- =============================================================================

if pcall(require, 'lspmappings') then
  require('lspmappings')
end


-- =============================================================================
-- Codeium
-- =============================================================================

if vim.fn.exists(':Codeium') == 2 then

  -- N.B. when running Codeium Auth make sure you are running in tmux,
  -- the token won't be parsed properly otherwise and you'll receive an error.

  vim.keymap.set('i', '<c-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
  vim.keymap.set('i', '<c-k>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
  vim.keymap.set('i', '<c-j>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
  vim.keymap.set('i', '<c-l>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  vim.keymap.set('i', '<c-h>', function() return vim.fn['codeium#Complete']() end, { expr = true, silent = true })

  -- Disable for certain file types
  vim.g.codeium_filetypes = {
    markdown = false,
  }

end


-- =============================================================================
-- GPT prompt
-- =============================================================================

if pcall(require, 'gp') then

  local gprompt = require('gp')

  gprompt.setup({
    -- openai_api_key = os.getenv("OPENAI_API_KEY"),
  })

  vim.keymap.set({ 'v','n' }, '<leader>gr', "<cmd>GpRewrite<cr>", { noremap = true, silent = true, buffer = true })
  vim.keymap.set({ 'v','n' }, '<leader>ga', "<cmd>GpAppend<cr>", { noremap = true, silent = true, buffer = true })
  vim.keymap.set({ 'v','n' }, '<leader>gp', "<cmd>GpPrepend<cr>", { noremap = true, silent = true, buffer = true })
  vim.keymap.set({ 'v','n' }, '<leader>gi', "<cmd>GpImplement<cr>", { noremap = true, silent = true, buffer = true })
  vim.keymap.set({ 'v','n' }, '<leader>gt', "<cmd>GpChatToggle popup<cr>", { noremap = true, silent = true, buffer = true })
  vim.keymap.set({ 'v','n' }, '<leader>gf', "<cmd>GpChatFinder<cr>", { noremap = true, silent = true, buffer = true })

end
