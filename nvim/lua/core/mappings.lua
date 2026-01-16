vim.g.mapleader = " "
vim.keymap.set("n", "-", vim.cmd.Ex)
vim.opt.clipboard = "unnamedplus"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fa', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


vim.keymap.set('n', 'H', ':bprevious<CR>')
vim.keymap.set('n', 'L', ':bnext<CR>')

--typst mapping
vim.keymap.set("n", "<leader>tp", ":TypstPreview<CR>", { desc = "Start Typst preview" })
vim.keymap.set("n", "<leader>ts", ":TypstPreviewStop<CR>", { desc = "Stop Typst preview" })
vim.keymap.set("n", "<leader>ta", ":TypstPreviewToggle<CR>", { desc = "Toggle Typst preview" })
vim.keymap.set("n", "<leader>tf", ":TypstPreviewFollowCursorToggle<CR>", { desc = "Toggle follow cursor" })
vim.keymap.set("n", "<leader>tc", ":TypstPreviewSyncCursor<CR>", { desc = "Sync preview to cursor" })

--window behavior
vim.keymap.set('n', '<leader>ws', '<CMD>vsplit<CR>');
vim.keymap.set('n', '<leader>wc', '<CMD>close<CR>');

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.backupcopy = "yes"   
vim.opt.writebackup = false 

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set('n', 'dl', '^D')

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
