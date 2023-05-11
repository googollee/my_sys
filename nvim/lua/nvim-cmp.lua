local M = {}

function M.init(packer)
  packer 'hrsh7th/cmp-nvim-lsp'
  packer 'hrsh7th/cmp-nvim-lua'
  packer 'hrsh7th/cmp-buffer'
  packer 'hrsh7th/cmp-path'
  packer 'hrsh7th/cmp-cmdline'
  packer 'onsails/lspkind.nvim'

  packer {
    'hrsh7th/nvim-cmp',

    config = function()
      -- Setup nvim-cmp.
      local lspkind = require("lspkind")
      lspkind.init()

      local cmp = require'cmp'

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer', keyword_length = 5 },
        },
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            mode = 'text',
            maxwidth = 40, -- half max width
            menu = {
              buffer   = "[BUF]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[API]",
              path     = "[PATH]",
            },
          }),
        },

        experimental = {
          native_menu = false,
          ghost_text = false,
        },
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  }
end

function M.capabilities()
  return require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

return M
