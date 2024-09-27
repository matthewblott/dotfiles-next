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
lspconfig.ts_ls.setup({})

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
    ['<cr>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    -- ['<C-Space>'] = cmp.mapping.complete(),

  })
})


