local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(p)
  require('editor')(p)
  require('telescope')(p)
  require('git')(p)
  require('treesitter')(p)
  require('lsp').init(p)
  require('nvim-cmp').init(p)
  -- require('nvim-compe')(p)

  require('lang/markdown')(p)
  require('lang/go')(p)
  require('lang/cider')(p)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

