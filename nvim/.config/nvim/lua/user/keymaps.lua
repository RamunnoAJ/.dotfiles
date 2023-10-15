local opts = {
  noremap = true,
  silent = true,
}

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Remap <space> to <leader>
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
