return function(use)
  use 'ziglang/zig.vim'

  require('lsp').config_lsp(function()
    cfg = {
      on_attach = require('lsp').on_attach(),
      capabilities = require('nvim-cmp').capabilities(),
    }

    local nvim_lsp = require('lspconfig')

    nvim_lsp.zls.setup(cfg)
  end)
end
