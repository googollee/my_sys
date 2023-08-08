local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd([[
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
]])

vim.g.mapleader = ","

local pkgs = {}

function use(pkg)
  table.insert(pkgs, pkg)
end

require('editor')(use)
require('telescope')(use)
require('git')(use)

require('treesitter')(use)
require('lsp').init(use)
require('nvim-cmp').init(use)

require('lang/markdown')(use)
require('lang/go')(use)
require('lang/cider')(use)

require("lazy").setup(pkgs)
