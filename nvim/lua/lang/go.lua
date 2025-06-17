return function(add, now, later)
  if vim.fn.expand('%:p'):find('/google/src/cloud', 1) ~= nil then
    return
  end

  vim.lsp.enable('gopls')
  vim.lsp.enable('golangci_lint_ls')

  add { source = 'ray-x/go.nvim' }
  require('go').setup()

  local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      require('go.format').goimports()
    end,
    group = format_sync_grp,
  })
 end
