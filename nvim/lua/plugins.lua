local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')

return require('packer').startup(function (use)
  -- Packer itself
  use 'wbthomason/packer.nvim'

  use 'chriskempson/vim-tomorrow-theme'
  use 'tpope/vim-sensible'
  use 'tpope/vim-fugitive' -- git
  use 'junegunn/gv.vim' -- git log
  use 'airblade/vim-gitgutter' -- git diff
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'jiangmiao/auto-pairs'
  use 'scrooloose/nerdcommenter'

  -- lsp and complete
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'sbdchd/neoformat'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function () vim.cmd ':TSUpdate' end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
end)
