local function vim_kv_args(args)
  local arg_strs = {}
  for key, arg in pairs(args) do
    table.insert(arg_strs, string.format('%s=%s', key, arg))
  end
  return table.concat(arg_strs, " ")
end

function augroup(name, autocmds)
  local cmds = {
    string.format('augroup %s', name),
    'autocmd!',
  }

  for _, cmd in ipairs(autocmds) do
    -- table.insert(cmds, M.autocmd(cmd))
    table.insert(cmds, cmd)
  end

  table.insert(cmds, 'augroup end')
  local cmd_strs = table.concat(cmds, '\n')
  vim.api.nvim_exec(cmd_strs, true)
end

function autocmd(event, pattern, command)
  return string.format('autocmd %s %s %s', event, pattern, command)
end

function set_highlight(group, args)
  local arg = vim_kv_args(args)
  vim.cmd(string.format('hi %s %s', group, arg))
end

local M = {}

function M.on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    set_highlight('LspReferenceRead', {cterm='bold', ctermbg='red', guibg='LightYellow'})
    set_highlight('LspReferenceText', {cterm='bold', ctermbg='red', guibg='LightYellow'})
    set_highlight('LspReferenceWrite', {cterm='bold', ctermbg='red', guibg='LightYellow'})
    augroup('lsp_document_highlight', {
      autocmd('CursorHold', '<buffer>', 'lua vim.lsp.buf.document_highlight()'),
      autocmd('CursorMoved', '<buffer>', 'lua vim.lsp.buf.clear_references()'),
      autocmd('CursorHold', '<buffer>', 'lua vim.lsp.diagnostic.show_line_diagnostics()'),
    })
  end

  -- format_on_save
  augroup('format_on_save', {
    autocmd('BufWritePre', '<buffer>', ':silent! lua require("lsp_settings").fmt()'),
  })
end

return M
