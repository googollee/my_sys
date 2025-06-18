return function(add, now, later)
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_toml_frontmatter = 1
  vim.g.vim_markdown_json_frontmatter = 1
  vim.g.vim_markdown_new_list_item_indent = 2
  vim.g.vim_markdown_folding_level = 6

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
      require('lsp').on_attach(args)
    end
  })

  vim.lsp.enable('markdown')
end
