vim.opt.colorcolumn = "+1"
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "+" }
vim.opt.pumblend = 0
vim.opt.swapfile = false
vim.opt.tabstop = 8
vim.opt.textwidth = 80
vim.opt.undofile = true
vim.opt.timeoutlen = 50
vim.opt.mousescroll = "ver:1,hor:6"

vim.opt.rtp:prepend(vim.env.HOME .. "/.local/share/vim/vimfiles")

vim.g.zig_fmt_autosave = false
vim.g.zig_fmt_parse_errors = false

vim.g.snacks_animate = false

vim.filetype.add({
  extension = {
    scfg = "scfg",
    shtml = "superhtml",
    smd = "supermd",
  },
})
