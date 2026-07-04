vim.opt.termguicolors = true

-- poimandres.nvim: Poimandres colorscheme for Neovim
-- https://github.com/olivercederborg/poimandres.nvim
local ok, poimandres = pcall(require, "poimandres")
if not ok then return end

poimandres.setup({
  bold_vert_split = false,
  dark_variant = "main",
  disable_background = true,
  disable_float_background = true,
  disable_italics = false,

  -- Brighten the dimmest groups so they stay readable over a
  -- transparent background (the dark blue-grays wash out otherwise).
  highlight_groups = {
    Comment    = { fg = "#8C93B8" }, -- nudged up for contrast
    LineNr     = { fg = "#6E7E97" }, -- was blueGray3 #506477 (too dark)
    Special    = { fg = "#9197B8" }, -- was blueGray2 #767C9D
    NonText    = { fg = "#8090AA" }, -- was blue4 #7390AA
    FoldColumn = { fg = "#9197B8" }, -- was blueGray2
    Whitespace = { fg = "#5A6B80" }, -- was blueGray3
  },
})

vim.cmd("colorscheme poimandres")
