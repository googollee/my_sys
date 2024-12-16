return function(use)
  util = require('util')

  use {
    'frankroeder/parrot.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'rcarriga/nvim-notify' },
    config = function()
      require("parrot").setup {
        -- Providers must be explicitly added to make them available.
        providers = {
          ollama = {
            topic = {
              model = "codellama",
              params = { max_tokens = 1024 },
            },
          },
        },
      }
    end,
  }

end
