local function vim_kv_args(args)
  local arg_strs = {}
  for key, arg in pairs(args) do
    table.insert(arg_strs, string.format('%s=%s', key, arg))
  end
  return table.concat(arg_strs, " ")
end

function sign_define(name, args)
  local arg = vim_kv_args(args)
  vim.cmd(string.format('sign define %s %s', name, arg))
end

local feature = require('fur.feature')

local f = feature:new('lsp-settings')
f.source = 'lua/lsp-settings.lua'
f.plugins = {
  'neovim/nvim-lspconfig',
}
f.setup = function()
  sign_define('LspDiagnosticsSignError', {text='x', texthl='LspDiagnosticsError', linehl='', numhl=''})
  sign_define('LspDiagnosticsSignWarning', {text='!', texthl='LspDiagnosticsWarning', linehl='', numhl=''})
  sign_define('LspDiagnosticsSignInformation', {text='~', texthl='LspDiagnosticsInformation', linehl='', numhl=''})
  sign_define('LspDiagnosticsSignHint', {text='?', texthl='LspDiagnosticsHint', linehl='', numhl=''})
end
f.mappings = {
}

return f
