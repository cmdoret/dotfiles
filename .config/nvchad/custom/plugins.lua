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
        "markdown",
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
        -- go
        "gopls",
        -- lua
        "lua-language-server",
        -- markdown
        "marksman",
        "prettier",
        -- python
        "pyright",
        "ruff",
        -- rust
        "rust-analyzer",
      },
    },
  },
}

return plugins
