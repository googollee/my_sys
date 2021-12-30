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

      cfg = {
        on_attach = require('lsp').on_attach,
      }

      local nvim_lsp = require 'lspconfig'

      -- go install golang.org/x/tools/gopls@latest
      nvim_lsp.gopls.setup(cfg)
      -- go install github.com/nametake/golangci-lint-langserver@latest
      -- go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
      nvim_lsp.golangci_lint_ls.setup{cfg}
    end,
  }
end
