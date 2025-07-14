vim.keymap.set("n", "<leader>fm", ":lua vim.lsp.buf.format()<cr>", { desc = "format" })
vim.keymap.set("n", "<leader>sr", ":FzfLua lsp_references<cr>", { desc = "view references in fzf-lua" })
