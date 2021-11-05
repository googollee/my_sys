function autocmd(event, pattern, command)
  return string.format('autocmd %s %s %s', event, pattern, command)
end

common = require('lang/common')

local feature = require('fur.feature')

local f = feature:new('lang.cider')
f.source = 'lua/lang/cider.lua'
f.setup = function()
  local nvim_lsp = require 'lspconfig'
  local configs = require 'lspconfig/configs'

  if not nvim_lsp.ciderlsp then
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
    on_attach = common.on_attach,
  }
  nvim_lsp['ciderlsp'].setup(cfg)

  autocmd("Filetype", "java", "set omnifunc=v:lua.vim.lsp.omnifunc")
  autocmd("Filetype", "proto", "set omnifunc=v:lua.vim.lsp.omnifunc")
  autocmd("Filetype", "go", "set omnifunc=v:lua.vim.lsp.omnifunc")
end

return f

