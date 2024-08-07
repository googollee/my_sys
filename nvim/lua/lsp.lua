local M = {}

local langs = {}

function M.config_lsp(fn)
  table.insert(langs, fn)
end

function M.init(use)
  use {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
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

      for _, fn in ipairs(langs) do
        fn()
      end
    end,
  }

  use "ray-x/lsp_signature.nvim"

  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      local util = require('util')
      util.noremap('n', '<C-e>', ':SymbolsOutline<CR>')
    end,
  }
end

function M.on_attach()
  return function(client, bufnr)
    require "lsp_signature".on_attach({
      floating_window_above_cur_line = true,
      hint_enable = false,
      hint_prefix = "P: ",
      timer_interval = 100,
    }, bufnr)

    local util = require('util')
    local set_highlight = util.set_highlight
    local augroup = util.augroup
    local autocmd = util.autocmd
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    if vim.lsp.formatexpr then -- Neovim v0.6.0+ only.
      vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
    end
    if vim.lsp.tagfunc then
      vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    end

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
      set_highlight('LspReferenceRead', {cterm='bold', ctermbg='red', guibg='LightYellow'})
      set_highlight('LspReferenceText', {cterm='bold', ctermbg='red', guibg='LightYellow'})
      set_highlight('LspReferenceWrite', {cterm='bold', ctermbg='red', guibg='LightYellow'})
      augroup('lsp_document_highlight', {
        autocmd('CursorHold', '<buffer>', 'lua vim.lsp.buf.document_highlight()'),
        autocmd('CursorHoldI', '<buffer>', 'lua vim.lsp.buf.document_highlight()'),
        autocmd('CursorMoved', '<buffer>', 'lua vim.lsp.buf.clear_references()'),
      })
    end

    -- format_on_save
    augroup('format_on_save', {
      autocmd('BufWritePre', '<buffer>', ':silent! lua require("lsp_settings").fmt()'),
    })
  end
end

return M
