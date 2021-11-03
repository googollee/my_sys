local feature = require('fur.feature')

local f = feature:new('lang.markdown')
f.source = 'lua/lang/markdown.lua'
f.setup = function()
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_toml_frontmatter = 1
  vim.g.vim_markdown_json_frontmatter = 1
  vim.g.vim_markdown_new_list_item_indent = 2
  vim.g.vim_markdown_folding_level = 6
end

return f

