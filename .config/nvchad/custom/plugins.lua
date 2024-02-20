local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "go",
        "python",
        "r",
        "rust",
      }
    }
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "lua-language-server",
        "prettier",
        "python-lsp-server",
        "ruff",
        "rust-analyzer",
      },
    },
  },
}

return plugins
