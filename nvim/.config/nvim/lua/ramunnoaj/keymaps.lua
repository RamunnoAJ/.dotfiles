local opts = {
  noremap = true,
  silent = true,
}

local keymap = vim.api.nvim_set_keymap

-- Remap <space> to <leader>
keymap("n", "<Space>", "<Nop>", opts)
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

keymap("n", "J", "mzJ`z", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

keymap("n", "<leader>t", "gt", opts)
keymap("n", "<leader>T", "gT", opts)

-- Exit insert mode
keymap("i", "<C-c>", "<Esc>", opts)

-- Disable Ex mode
keymap("n", "Q", "<nop>", opts)

-- Better navigation with <C-d> and <C-u>
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Surround selection with brackets
keymap("v", "(", "<esc>`>a)<esc>`<i(<esc>gv", opts)
keymap("v", "[", "<esc>`>a]<esc>`<i[<esc>gv", opts)
keymap("v", "{", "<esc>`>a}<esc>`<i{<esc>gv", opts)
keymap("v", "'", "<esc>`>a'<esc>`<i'<esc>gv", opts)
keymap("v", '"', '<esc>`>a"<esc>`<i"<esc>gv', opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Keep selection after yanking
keymap("x", "y", "ygv", opts)

-- Indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- I want move line up/down consinusly, not moving & inserting
keymap("n", "<M-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<M-k>", "<Esc>:m .-2<CR>==", opts)
keymap("v", "<M-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<M-k>", ":m '<-2<CR>gv=gv", opts)

-- Better paste
keymap("v", "p", '"_dp', opts)
keymap("v", "P", '"_dP', opts)
keymap('n', ',p', '"0p', opts)
keymap('n', ',P', '"0P', opts)

-- Delete don't yank
keymap('n', 'x', '"_x', opts)
keymap('v', 'x', '"_x', opts)
keymap('n', 'd', '"_d', opts)
keymap('v', 'd', '"_d', opts)

-- Change don't yank
keymap('n', 'c', '"_c', opts)
keymap('v', 'c', '"_c', opts)

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
keymap('n', '<leader>e', ':e .<CR>', opts)
keymap('n', '<leader>c', ':Bdelete!<CR>', opts)
keymap('n', '<leader>C', ":silent w!|%bd|e#|bd#|'\"<CR>", opts)
keymap('n', '<leader>q', ":clo<CR>", opts)

-- Harpoon
keymap('n', '<leader>a', ':lua require("harpoon"):list():append()<CR>', opts)
keymap('n', '<C-a>', ':lua require("harpoon"):list():select(1)<CR>', opts)
keymap('n', '<C-s>', ':lua require("harpoon"):list():select(2)<CR>', opts)
keymap('n', '<C-e>', ':lua require("harpoon"):list():select(3)<CR>', opts)
keymap('n', '<C-f>', ':lua require("harpoon"):list():select(4)<CR>', opts)

-- Telescope
keymap('n', '<leader>f', ':lua require("telescope.builtin").find_files({hidden=true})<CR>', opts)
keymap('n', '<leader>F', ':lua require("telescope.builtin").buffers()<CR>', opts)
keymap('n', '<leader>sg', ':lua require("telescope.builtin").live_grep()<CR>', opts)
keymap('n', '<leader>sc', ':lua require("telescope.builtin").commands()<CR>', opts)
keymap('n', '<leader>sk', ':lua require("telescope.builtin").keymaps()<CR>', opts)

-- LSP
keymap('n', '<leader>vi', ':LspInfo<CR>', opts)
keymap('n', '[d', ':lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', ']d', ':lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', '<leader>vw', ':lua vim.diagnostic.workspace_symbol()<CR>', opts)
keymap('n', '<leader>vc', ':lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<leader>vr', ':lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<leader>va', ':lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', '<leader>vh', ':lua vim.lsp.buf.help()<CR>', opts)

-- Debugging
keymap('n', '<leader>b', ':lua require("dap").toggle_breakpoint()<CR>', opts)
keymap('n', '<leader>B', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
keymap('n', '<F5>', ':lua require("dap").continue()<CR>', opts)
keymap('n', '<F10>', ':lua require("dap").step_over()<CR>', opts)
keymap('n', '<F11>', ':lua require("dap").step_into()<CR>', opts)
keymap('n', '<F12>', ':lua require("dap").step_out()<CR>', opts)
keymap('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)

-- Git
keymap('n', '<leader>g', ':vertical Git<CR>', opts)
keymap('n', '<leader>u', ':UndotreeToggle<CR>', opts)

-- Open glow
keymap('n', '<leader>mp', ':term glow %<CR>', opts)
keymap('n', '<leader>mt', ':term glow ~/.dotfiles/personal/TODO.md<CR>', opts)
