vim.g.netrw_list_hide = "^./$"
vim.g.netrw_hide = 1
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.opt_local.colorcolumn = "0"

vim.keymap.set("n", "<C-c>", ":Rex<CR>", { remap = true, buffer = true })
vim.keymap.set("n", "h", "-", { remap = true, buffer = true })
vim.keymap.set("n", "l", "<CR>", { remap = true, buffer = true })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { remap = true, buffer = true })
