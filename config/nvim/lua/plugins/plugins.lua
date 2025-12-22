return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
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
