function augroup(name, autocmds)
  local cmds = {
    string.format('augroup %s', name),
    'autocmd!',
  }

  for _, cmd in ipairs(autocmds) do
    -- table.insert(cmds, M.autocmd(cmd))
    table.insert(cmds, cmd)
  end

  table.insert(cmds, 'augroup end')
  local cmd_strs = table.concat(cmds, '\n')
  vim.api.nvim_exec(cmd_strs, true)
end

function autocmd(event, pattern, command)
  return string.format('autocmd %s %s %s', event, pattern, command)
end

common = require('lang/common')

local feature = require('fur.feature')

local f = feature:new('lang.go')
f.plugins = {
  'ray-x/go.nvim',
}
f.source = 'lua/lang/go.lua'
f.setup = function()
  -- vim.fn.system({'go', 'install', 'golang.org/x/tools/cmd/goimports@latest'})
  -- vim.fn.system({'go', 'install', 'golang.org/x/tools/gopls@latest'})

  require('go').setup()

  augroup('fmt', {
    autocmd('BufNewFile,BufRead', '*.go', 'setlocal noexpandtab tabstop=2 shiftwidth=2'),
    autocmd('BufWritePre', '*.go', "lua require('go.format').goimport()"),
  })

  local nvim_lsp = require 'lspconfig'
  local configs = require 'lspconfig/configs'

  if not nvim_lsp.golangcilsp then
    configs.golangcilsp = {
      default_config = {
        cmd = {'golangci-lint'},
        root_dir = nvim_lsp.util.root_pattern('.git', 'go.mod'),
        filetypes = {'go'},
        init_options = {
          command = { "golangci-lint", "run", "--fast", "--out-format", "json" };
        },
      };
    }
  end

  cfg = {
    on_attach = common.on_attach,
  }
  nvim_lsp['gopls'].setup(cfg)
  nvim_lsp['golangcilsp'].setup(cfg)
end

return f
