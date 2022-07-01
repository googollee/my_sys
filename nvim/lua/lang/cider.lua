return function(packer)
  if vim.fn.expand('%:p'):find('/google/src/cloud', 1) == nil then
    return
  end

  local util = require('util')
  local augroup = util.augroup
  local autocmd = util.autocmd

  augroup('fmt', {
    autocmd('BufNewFile,BufRead', '*.go', 'setlocal noexpandtab tabstop=2 shiftwidth=2')
  })

  vim.cmd([[
  source /usr/share/vim/google/glug/bootstrap.vim

  Glug blaze plugin[mappings]
  Glug blazedeps plugin[mappings] auto_filetypes=`['go']`
  Glug codefmt gofmt_executable="goimports"
  Glug codefmt-google

  augroup autoformat_settings
    autocmd FileType borg,gcl,patchpanel AutoFormatBuffer gclfmt
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,javascript,typescript AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType jslayout AutoFormatBuffer jslfmt
    autocmd FileType markdown AutoFormatBuffer mdformat
    autocmd FileType ncl AutoFormatBuffer nclfmt
    autocmd FileType python AutoFormatBuffer pyformat
    autocmd FileType soy AutoFormatBuffer soyfmt
    autocmd FileType textpb AutoFormatBuffer text-proto-format
    autocmd FileType proto AutoFormatBuffer protofmt
    autocmd FileType sql AutoFormatBuffer format_sql
    autocmd FileType html,css,json AutoFormatBuffer js-beautify
  augroup END
  ]])

  local nvim_lsp = require 'lspconfig'
  local configs = require 'lspconfig.configs'

  configs.ciderlsp = {
    default_config = {
      cmd = {'/google/bin/releases/cider/ciderlsp/ciderlsp', '--tooltag=nvim-lsp' , '--noforward_sync_responses'};
      filetypes = {'c', 'cpp', 'java', 'proto', 'textproto', 'go', 'python', 'bzl'};
      root_dir = nvim_lsp.util.root_pattern('BUILD');
      settings = {};
    }
  }

  cfg = {
    on_attach = function (client, bufnr)
      require('lsp').on_attach(client, bufnr)

      -- Omni-completion via LSP. See `:help compl-omni`. Use <C-x><C-o> in
      -- insert mode. Or use an external autocompleter (see below) for a
      -- smoother UX.
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      if vim.lsp.formatexpr then -- Neovim v0.6.0+ only.
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
      end
      if vim.lsp.tagfunc then -- Neovim v0.6.0+ only.
        -- Tag functionality via LSP. See `:help tag-commands`. Use <c-]> to
        -- go-to-definition.
        vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
      end
    end,
    capabilities = require('nvim-cmp').capabilities(),
  }
  nvim_lsp.ciderlsp.setup(cfg)
end
