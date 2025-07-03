local M = {}

function M.on_attach(args)
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

  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover({border="single"})<CR>', opts)
  vim.keymap.set('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.keymap.set('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.keymap.set('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.keymap.set('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.keymap.set('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

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

return M
