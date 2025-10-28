-- after/plugin/harpoon.lua
local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon:setup()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Add file
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():append()
end)

-- Toggle menu
vim.keymap.set("n", "<leader>e", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>hc", function()
  harpoon:list():clear()
end)

-- Quick jump
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
