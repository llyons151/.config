require("core.plugins")
require("core.cmp")
require("core.mappings")
require("core.options")
require("core.colors")
require("core.diagnostics")
require("core.telescope")
require("core.lsp")

local function kill_line_nr_bg()
  for _, g in ipairs({ "CursorLineNr", "LineNr", "SignColumn" }) do
    vim.api.nvim_set_hl(0, g, { bg = "NONE", ctermbg = "NONE" })
  end
end

kill_line_nr_bg()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("NoLineNrBG", { clear = true }),
  callback = kill_line_nr_bg,
})

vim.o.termguicolors = true
vim.api.nvim_set_hl(0, "Normal",     { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "NONE" })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal",      { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  end,
})

vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000", fg = "#d4d4d4" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#1f1f1f", fg = "#ffffff" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5e81ac", bg = "#000000" })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000", fg = "#d4d4d4" })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#1f1f1f", fg = "#ffffff" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#5e81ac", bg = "#000000" })
  end,
})
