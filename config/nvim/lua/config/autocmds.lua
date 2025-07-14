vim.api.nvim_create_autocmd("Filetype", {
  pattern = "go",
  callback = function()
    vim.opt.shiftwidth = 8
  end,
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "zig",
  callback = function()
    vim.opt.textwidth = 100
  end,
})
