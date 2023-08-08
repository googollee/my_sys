return function(use)

  require("lsp").config_lsp(function()
    if vim.fn.expand('%:p'):find('/google/src/cloud', 1) == nil then
      return
    end

    local util = require('util')
    local augroup = util.augroup
    local autocmd = util.autocmd

    augroup('fmt', {
      autocmd('BufNewFile,BufRead', '*.go', 'setlocal noexpandtab tabstop=2 shiftwidth=2'),
      autocmd('BufWritePost,FileWritePost', '*.go', 'silent! %!goimports'),
      autocmd('BufWritePost,FileWritePost', '*.go', 'silent! !glaze .'),
    })

    local nvim_lsp = require('lspconfig')
    local configs = require('lspconfig.configs')

    configs.ciderlsp = {
      default_config = {
        cmd = { "/google/bin/releases/cider/ciderlsp/ciderlsp", "--tooltag=nvim-cmp", "--noforward_sync_responses" },
        filetypes = { "c", "cc", "h", "cpp", "java", "kotlin", "objc", "proto", "textproto", "go", "python", "bzl" },
        root_dir = nvim_lsp.util.root_pattern("BUILD"),
        settings = {},
      },
    }

    cfg = {
      on_attach = require('lsp').on_attach(),
      capabilities = require('nvim-cmp').capabilities(),
    }
    nvim_lsp.ciderlsp.setup(cfg)
  end)
end
