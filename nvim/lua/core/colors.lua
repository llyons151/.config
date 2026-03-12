vim.opt.termguicolors = true

local ok, rose_pine = pcall(require, "rose-pine")
if not ok then return end

rose_pine.setup({
    variant = "main",
    dark_variant = "main",
    disable_background = false,
    disable_float_background = false,
    disable_italics = false,

    highlight_groups = {
        ["@keyword"]            = { fg = "#FFFFFF",  italic = true },
        ["@keyword.function"]   = { fg = "iris",  italic = true },
        ["@conditional"]        = { fg = "iris",  italic = true },
        ["@repeat"]             = { fg = "iris",  italic = true },
        ["@function"]           = { fg = "pine",  bold = true },
        ["@function.builtin"]   = { fg = "pine",  bold = true },
        ["@variable"]           = { fg = "foam" },
        ["@variable.builtin"]   = { fg = "foam" },

        Keyword  = { fg = "iris",  italic = true },
        Function = { fg = "pine",  bold = true },
        Variable = { fg = "foam"  },
        Comment  = { italic = true },
    },
})

vim.cmd("colorscheme rose-pine")

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "@keyword.lua",      { fg = "#C4A7E7", italic = true })
        vim.api.nvim_set_hl(0, "@conditional.lua",  { fg = "#C4A7E7", italic = true })
        vim.api.nvim_set_hl(0, "@repeat.lua",       { fg = "#C4A7E7", italic = true })
        vim.api.nvim_set_hl(0, "Statement",         { fg = "#C4A7E7", italic = true })
        vim.api.nvim_set_hl(0, "@function.call", { fg = "#89dceb" })
        vim.api.nvim_set_hl(0, "@lsp.type.function.typescriptreact", { fg = "#89dceb" })
        vim.api.nvim_set_hl(0, "@lsp.type.function", { fg = "#89dceb" })
    end,
})

