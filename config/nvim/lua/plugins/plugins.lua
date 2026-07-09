return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "radix-dark",
    },
  },
  {
    "rockorager/radix.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "dark",
      transparent = false,
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            auto_close = true,
            layout = { preset = "default" },
          },
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        superhtml = {},
        ziggy = {},
        ziggy_schema = {},
        fish_lsp = {},
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        blueprint_ls = {},
      },
    },
  },
}
