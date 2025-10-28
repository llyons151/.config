vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"


    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { "nvim-lua/plenary.nvim" }
    }

    use {
        'chomosuke/typst-preview.nvim',
        tag = 'v1.*',
        config = function()
            require 'typst-preview'.setup {}
        end,
    }
    use {
        "cocopon/iceberg.vim",
        config = function()
            vim.cmd("colorscheme iceberg")
        end
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})

end)
