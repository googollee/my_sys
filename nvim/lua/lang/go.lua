return function(packer)
  packer {
    'ray-x/go.nvim',

    config = function()
      require('go').setup()

      local util = require('util')
      local augroup = util.augroup
      local autocmd = util.autocmd

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
        on_attach = require('lsp').on_attach,
      }
      nvim_lsp['gopls'].setup(cfg)
      nvim_lsp['golangcilsp'].setup(cfg)
    end,
  }
end
