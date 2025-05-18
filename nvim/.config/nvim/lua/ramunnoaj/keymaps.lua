-- Remap <space> to <leader>
vim.keymap.set({ "n", "v" }, " ", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "J", "mzJ`z", { silent = true }) -- Don't move the cursor when doing J
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>t", "gt")
vim.keymap.set("n", "<leader>T", "gT")

vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Better navigation with <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Surround selection with brackets
vim.keymap.set("v", "(", "<esc>`>a)<esc>`<i(<esc>gv")
vim.keymap.set("v", "[", "<esc>`>a]<esc>`<i[<esc>gv")
vim.keymap.set("v", "{", "<esc>`>a}<esc>`<i{<esc>gv")
vim.keymap.set("v", "'", "<esc>`>a'<esc>`<i'<esc>gv")
vim.keymap.set("v", '"', '<esc>`>a"<esc>`<i"<esc>gv')
vim.keymap.set("v", '`', '<esc>`>a`<esc>`<i`<esc>gv')

-- Keep selection after yanking
vim.keymap.set("x", "y", "ygv")

-- Keep selection after Indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move text up and down
vim.keymap.set("n", "<M-j>", "<Esc>:m .+1<CR>==")
vim.keymap.set("n", "<M-k>", "<Esc>:m .-2<CR>==")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Better paste
vim.keymap.set("v", "p", '"_dp')
vim.keymap.set("v", "P", '"_dP')
vim.keymap.set("n", ",p", '"0p')
vim.keymap.set("n", ",P", '"0P')

-- Delete don't yank
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("v", "x", '"_x')
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("v", "d", '"_d')
vim.keymap.set("n", "D", '"_D')
vim.keymap.set("v", "D", '"_D')

-- Change don't yank
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("v", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("v", "C", '"_C')

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

vim.keymap.set("n", "<leader>c", ":bw!<CR>", { silent = true })                      -- Close buffer
vim.keymap.set("n", "<leader>C", ":silent w!|%bd|e#|bd#|'\"<CR>", { silent = true }) -- Close all buffers except current
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { silent = true })                      -- Remove highlight search
vim.keymap.set("n", "<leader>e", "<cmd>:Ex<CR>")

-- Quickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set("n", "[c", ":cnext<CR>")
vim.keymap.set("n", "]c", ":cprev<CR>")

-- Harpoon
vim.keymap.set("n", "<leader>a", ":lua require('harpoon'):list():add()<CR>")
vim.keymap.set("n", "<C-h>", ":lua require('harpoon'):list():select(1)<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":lua require('harpoon'):list():select(2)<CR>", { silent = true })
vim.keymap.set("n", "<C-a>", ":lua require('harpoon'):list():select(3)<CR>", { silent = true })
vim.keymap.set("n", "<C-s>", ":lua require('harpoon'):list():select(4)<CR>", { silent = true })

-- Telescope
vim.keymap.set("n", "<leader>f", ":lua require('telescope.builtin').find_files({hidden=true})<CR>")
vim.keymap.set("n", "<leader>F", ":lua require('telescope.builtin').buffers()<CR>")
vim.keymap.set("n", "<C-p>", ":lua require('telescope.builtin').git_files()<CR>")
vim.keymap.set("n", "<leader>sg", ":lua require('telescope.builtin').live_grep()<CR>")
vim.keymap.set("n", "<leader>sc", ":lua require('telescope.builtin').commands()<CR>")
vim.keymap.set("n", "<leader>sk", ":lua require('telescope.builtin').keymaps()<CR>")
vim.keymap.set("n", "<leader>sh", ":lua require('telescope.builtin').help_tags()<CR>")

-- LSP
vim.keymap.set("n", "<leader><leader>",
    ":lua vim.diagnostic.open_float()<CR>:lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "<leader>r", ":lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<leader>a", ":lua vim.lsp.buf.code_action()<CR>")

vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- Open glow
vim.keymap.set("n", "<leader>mp", ":term glow %<CR>")
vim.keymap.set("n", "<leader>mt", ":term glow ~/.dotfiles/personal/TODO.md<CR>")

-- Toggle signcolumn
vim.keymap.set("n", "<leader>z", function()
    local signcolumn = vim.wo.signcolumn

    if signcolumn == "yes" then
        vim.wo.signcolumn = "yes:9"
    else
        vim.wo.signcolumn = "yes"
    end
end)

-- Show signature help on insert mode to see function's parameters
vim.keymap.set("i", "<C-k>", function()
    vim.lsp.buf.signature_help()
end, { desc = "Signature Help" })
