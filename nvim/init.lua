-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.opt.wrap = true
-- vim.opt.termguicolors = true
vim.opt.foldenable = false
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.cursorline = true
vim.opt.expandtab = true vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars:append('eol:↴')
vim.opt.listchars:append('tab:¦ ')
vim.opt.listchars:append('trail:·')
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.backspace = 'indent,eol,start'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.modeline = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.magic = true
vim.opt.smarttab = true
vim.opt.enc = 'utf-8'
vim.opt.fenc = 'utf-8'
vim.opt.conceallevel = 1
vim.opt.updatetime = 1000
vim.opt.mouse = ''
vim.opt.showtabline = 2

vim.api.nvim_set_hl(0, 'TabLineSel', {ctermfg = 'white'})

vim.cmd 'syntax on'
vim.cmd 'filetype on'
vim.cmd 'filetype plugin on'
vim.cmd 'filetype indent on'

vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<C-w>', ':tabnew<CR>')
vim.keymap.set('n', '<C-u>', ':tabprev<CR>')
vim.keymap.set('n', '<C-i>', ':tabnext<CR>')

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
