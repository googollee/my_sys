return function(add, now, later)
  add {
    source = 'neovim/nvim-lspconfig',
    depends = { 
      'williamboman/mason.nvim',
    }
  }

  local function vim_kv_args(args)
    local arg_strs = {}
    for key, arg in pairs(args) do
      table.insert(arg_strs, string.format('%s=%s', key, arg))
    end
    return table.concat(arg_strs, " ")
  end

  local function sign_define(name, args)
    local arg = vim_kv_args(args)
    vim.cmd(string.format('sign define %s %s', name, arg))
  end

  sign_define('LspDiagnosticsSignError',
    {text='x', texthl='LspDiagnosticsError', linehl='', numhl=''})
  sign_define('LspDiagnosticsSignWarning',
    {text='!', texthl='LspDiagnosticsWarning', linehl='', numhl=''})
  sign_define('LspDiagnosticsSignInformation',
    {text='~', texthl='LspDiagnosticsInformation', linehl='', numhl=''})
  sign_define('LspDiagnosticsSignHint',
    {text='?', texthl='LspDiagnosticsHint', linehl='', numhl=''})

  add {
    source = "ray-x/lsp_signature.nvim",
  }

  add {
    source = 'simrat39/symbols-outline.nvim',
  }
  require("symbols-outline").setup()

  local util = require('util')
  util.noremap('n', '<C-e>', ':SymbolsOutline<CR>')
end
