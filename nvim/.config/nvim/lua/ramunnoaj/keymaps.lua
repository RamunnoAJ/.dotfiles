local opts = {
  noremap = true,
  silent = true,
}

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Remap <space> to <leader>
vim.api.nvim_set_keymap("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
--[[ keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts) ]]
--[[ keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts) ]]
-- I want move line up/down consinusly, not moving & inserting
keymap("n", "[j", "<Esc>:m .+1<CR>==", opts)
keymap("n", "[k", "<Esc>:m .-2<CR>==", opts)

-- Better paste
keymap("v", "p", '"_dp', opts)
keymap("v", "P", '"_dP', opts)
keymap('n', ',p', '"0p', opts)
keymap('n', ',P', '"0P', opts)

-- Delete character don't yank
keymap('n', 'x', '"_x', opts)
keymap('v', 'x', '"_x', opts)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Misc
keymap('n', '<leader>w', ':w!<CR>', opts)
keymap('n', '<leader>e', ':e .<CR>', opts)
keymap('n', '<leader>c', ':Bdelete!<CR>', opts)
keymap('n', '<leader>C', ":w!|%bd|e#|bd#|'\"<CR>", opts)
keymap('n', '<leader>Q', ":w!|%bd|e#|bd#|'\"|q!<CR>", opts)

-- Harpoon
keymap('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', opts)
keymap('n', '<leader>hh', ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap('n', '<leader>hj', ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap('n', '<leader>hk', ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap('n', '<leader>hl', ':lua require("harpoon.ui").nav_file(4)<CR>', opts)

-- Telescope
keymap('n', '<leader>f', ':Telescope find_files hidden=true no_ignore=true<CR>', opts)
keymap('n', '<leader>F', ':Telescope buffers<CR>', opts)
keymap('n', '<leader>sg', ':Telescope live_grep<CR>', opts)
keymap('n', '<leader>sh', ':Telescope help_tags<CR>', opts)
keymap('n', '<leader>sc', ':Telescope commands<CR>', opts)
keymap('n', '<leader>sk', ':Telescope keymaps<CR>', opts)
keymap('n', '<leader>sd', ':Telescope diagnostics bfnr=0', opts)

-- LSP
keymap('n', '<leader>lf', ':lua vim.lsp.buf.format({ async = true })<CR>', opts)
keymap('n', '<leader>lm', ':Mason<CR>', opts)
keymap('n', '<leader>li', ':LspInfo<CR>', opts)
keymap('n', '<leader>lj', ':lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<leader>lk', ':lua vim.diagnostic.goto_prev()<CR>', opts)

-- Open LazyGit
keymap('n', '<leader>gg', ':LazyGit<CR>', opts)
