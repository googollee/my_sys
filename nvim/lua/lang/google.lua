return function(use)
  if vim.fn.expand('%:p'):find('/google/src/cloud', 1) == nil then
    return
  end

  require("lazy").setup({
    {
      url = "sso://user/fentanes/nvgoog",
      import = "nvgoog.default",
    },
  })
end
