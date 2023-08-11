return function(use)
  if vim.fn.expand('%:p'):find('/google/src/cloud', 1) == nil then
    return
  end

  local function goog(plugin, config)
    use({
      name = plugin,
      dir = "/usr/share/vim/google/" .. plugin,
      dependencies = { "maktaba" },
      config = config,
    })
  end

  use {
    name = "maktaba",
    dir = "/usr/share/vim/google/maktaba",
    init = function ()
      vim.cmd("source /usr/share/vim/google/glug/bootstrap.vim")
    end,
  }
  goog("core")
  goog("glaive")
  goog("google-filetypes")
  goog("ft-cpp")
  goog("ft-go")
  goog("ft-java")
  goog("ft-kotlin")
  goog("ft-proto")
  goog("ft-python")

  goog("ultisnips-google")
  goog("autogen")
  goog("blaze")
  goog("blazedeps")
  goog("codefmt")
  goog("codefmt-google")
  goog("googlestyle")
  goog("relatedfiles", function()
    util = require('util')
    util.noremap('n', "<leader>r", ":RelatedFilesWindow<cr>")
  end)

  require("lsp").config_lsp(function()
    vim.cmd([[
    augroup autoformat_settings
      autocmd FileType borg,gcl,patchpanel AutoFormatBuffer gclfmt
      autocmd FileType bzl AutoFormatBuffer buildifier
      autocmd FileType c,cpp,javascript AutoFormatBuffer clang-format
      autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
      autocmd FileType dart AutoFormatBuffer dartfmt
      autocmd FileType go AutoFormatBuffer gofmt
      autocmd FileType html,css,json AutoFormatBuffer js-beautify
      autocmd FileType java AutoFormatBuffer google-java-format
      autocmd FileType jslayout AutoFormatBuffer jslfmt
      autocmd FileType markdown AutoFormatBuffer mdformat
      autocmd FileType ncl AutoFormatBuffer nclfmt
      autocmd FileType proto AutoFormatBuffer protofmt
      autocmd FileType python AutoFormatBuffer pyformat
      autocmd FileType sql AutoFormatBuffer format_sql
      autocmd FileType textpb AutoFormatBuffer text-proto-format
    augroup END
    ]])

    local util = require('util')
    local augroup = util.augroup
    local autocmd = util.autocmd

    augroup('fmt', {
      autocmd('BufNewFile,BufRead', 'go', 'setlocal noexpandtab tabstop=2 shiftwidth=2'),
    })

    local nvim_lsp = require('lspconfig')
    local configs = require('lspconfig.configs')

    configs.ciderlsp = {
      default_config = {
        cmd = { '/google/bin/releases/cider/ciderlsp/ciderlsp', '--tooltag=nvim-lsp', '--noforward_sync_responses' };
        filetypes = { "c", "cpp", "h", "java", "kotlin", "objc", "proto", "textproto", "go", "python", "bzl" },
        offset_encoding = 'utf-8',
        root_dir = nvim_lsp.util.root_pattern('google3/*BUILD');
        settings = {};
      }
    }

     cfg = {
      on_attach = require('lsp').on_attach(),
      capabilities = require('nvim-cmp').capabilities(),
    }
    nvim_lsp.ciderlsp.setup(cfg)
  end)
end
