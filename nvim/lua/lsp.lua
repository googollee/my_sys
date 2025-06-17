return function(add, now, later)
  add { source = 'neovim/nvim-lspconfig' }

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

  add { source = 'onsails/lspkind.nvim' }
  require('lspkind').init({
    mode = 'text',
  })

  add { source = 'hedyhli/outline.nvim' }
  vim.keymap.set('n', '<C-e>', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })
  require('outline').setup({
    symbols = {
      icon_fetcher = function(k, buf)
        if k == 'String' then
          return ""
        end
        return false
      end,
      icon_source = 'lspkind',
    }
  })
end
