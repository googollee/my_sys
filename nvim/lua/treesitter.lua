return function(add, now, later)
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })

  -- Possible to immediately execute code which depends on the added plugin
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'vimdoc' },
    highlight = { enable = true },
  })
end
