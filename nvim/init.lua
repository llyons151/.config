require("core.plugins")
require("core.harpoon")
require("core.mappings")
require("core.options")
require("core.colors")
require("core.diagnostics")
require("core.telescope")

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

-- enable true color
vim.o.termguicolors = true

-- make main backgrounds transparent
vim.api.nvim_set_hl(0, "Normal",     { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat",{ bg = "NONE" })

-- keep transparency after changing colorschemes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal",      { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  end,
})
