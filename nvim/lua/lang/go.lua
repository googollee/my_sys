return function(use)
  use {
    'ray-x/go.nvim',

    config = function()
      require('go').setup({
        goimports = 'gopls',
        gofmt = 'gopls',
      })
    end,
  }

  require('lsp').config_lsp(function()
    if vim.fn.expand('%:p'):find('/google/src/cloud', 1) ~= nil then
      return
    end

    cfg = {
      on_attach = require('lsp').on_attach(),
      capabilities = require('nvim-cmp').capabilities(),
      settings = {
        hints = {
          rangeVariableTypes = true,
          parameterNames = true,
          constantValues = true,
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          functionTypeParameters = true,
        },
      },
    }

    local nvim_lsp = require('lspconfig')

    -- go install golang.org/x/tools/gopls@latest
    nvim_lsp.gopls.setup(cfg)
    -- go install github.com/nametake/golangci-lint-langserver@latest
    -- go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    nvim_lsp.golangci_lint_ls.setup{cfg}

    local util = require('util')
    local augroup = util.augroup
    local autocmd = util.autocmd

    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require('go.format').goimport()
      end,
      group = format_sync_grp,
    })
  end)
end
