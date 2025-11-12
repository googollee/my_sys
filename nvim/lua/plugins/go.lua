return {
  {
    'ray-x/go.nvim',
    ft = 'go',
    opts = {},
    config = function(lp, opts)
      require('go').setup(opts)

      vim.lsp.enable('gopls')
      vim.lsp.enable('golangci_lint_ls')

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('gopls', { capabilities = capabilities })
      vim.lsp.config('golangci_lint_ls', { capabilities = capabilities })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('go.lsp', {}),
        callback = function(args)
          require('lsp').on_attach(args)

          local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
              require('go.format').goimports()
            end,
            group = format_sync_grp,
          })
        end
      })

    end,
  }
}
