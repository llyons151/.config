vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  -- Autocomplete
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"

  -- LSP
  use "neovim/nvim-lspconfig"
  use { "williamboman/mason.nvim", run = ":MasonUpdate" }
  use "williamboman/mason-lspconfig.nvim"

  -- Colors
  use {
    "cocopon/iceberg.vim",
    config = function()
      vim.cmd("colorscheme iceberg")
    end
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    requires = { "nvim-lua/plenary.nvim" }
  }

  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
end)
