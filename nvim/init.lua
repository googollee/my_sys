local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/fur.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ 'git', 'clone', '--depth=1', 'https://github.com/nanozuki/fur.nvim', install_path })
  vim.cmd('packadd fur.nvim')
end

vim.cmd([[command! FurReload      lua require('fur').reload()]])
vim.cmd([[command! FurPlugCompile lua require('fur').plug_compile()]])
vim.cmd([[command! FurPlugSync    lua require('fur').plug_sync()]])

local fur = require('fur')
fur.features = {
  require('editor'),
  require('telescope'),
  require('git'),
  require('nvim-compe'),
  require('lsp-settings'),

  require('lang/go'),
  require('lang/markdown'),
}
fur.start()
