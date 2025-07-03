if vim.fn.expand('%:p'):find('/google/src/cloud', 1) == nil then
  return {}
end

return {
  {
    url = "sso://user/fentanes/nvgoog",
    import = "nvgoog.default",
  },
}

