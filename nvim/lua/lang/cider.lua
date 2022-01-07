return function(packer)
  if vim.fn.expand('%:p'):find('/google/src/cloud', 1) == nil then
    return
  end

  local nvim_lsp = require 'lspconfig'
  local configs = require 'lspconfig.configs'

  if not configs.ciderlsp then
    configs.ciderlsp = {
      default_config = {
        cmd = {'/google/bin/releases/cider/ciderlsp/ciderlsp', '--tooltag=nvim-lsp' , '--noforward_sync_responses'};
        filetypes = {'c', 'cpp', 'java', 'proto', 'textproto', 'go', 'python', 'bzl'};
        root_dir = nvim_lsp.util.root_pattern('BUILD');
        settings = {};
      };
    }
  end

  cfg = {
    on_attach = require('lsp').on_attach,
    capabilities = require('nvim-cmp').capabilities(),
  }
  nvim_lsp.ciderlsp.setup(cfg)
end
