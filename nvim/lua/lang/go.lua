return function(packer)
  if vim.fn.expand('%:p'):find('/google/src/cloud', 1) ~= nil then
    return
  end

  cfg = {
    on_attach = require('lsp').on_attach(),
    capabilities = require('nvim-cmp').capabilities(),
  }

  local nvim_lsp = require 'lspconfig'

  -- go install golang.org/x/tools/gopls@latest
  nvim_lsp.gopls.setup(cfg)
  -- go install github.com/nametake/golangci-lint-langserver@latest
  -- go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  nvim_lsp.golangci_lint_ls.setup{cfg}

  local util = require('util')
  local augroup = util.augroup
  local autocmd = util.autocmd

  augroup('fmt', {
    autocmd('BufNewFile,BufRead', '*.go', 'setlocal noexpandtab tabstop=2 shiftwidth=2'),
    autocmd('BufWritePre', '*.go', "lua require('go.format').goimport()"),
  })

  packer {
    'ray-x/go.nvim',

    config = function()
      require('go').setup({
        goimport = 'gopls',
        gofmt = 'gopls',
      })
    end,
  }
end
