-- Remap <space> to <leader>
vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>t", "gt")
vim.keymap.set("n", "<leader>T", "gT")

-- Exit insert mode
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

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")

-- Keep selection after yanking
vim.keymap.set("x", "y", "ygv")

-- Indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move text up and down
-- I want move line up/down consinusly, not moving & inserting
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

-- Change don't yank
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("v", "c", '"_c')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- Misc
vim.keymap.set("n", "<leader>e", ":e .<CR>")
vim.keymap.set("n", "<leader>c", ":Bdelete!<CR>")
vim.keymap.set("n", "<leader>C", ":silent w!|%bd|e#|bd#|'\"<CR>")
vim.keymap.set("n", "<leader>q", ":clo<CR>")

-- Harpoon
vim.keymap.set("n", "<leader>a", ":lua require('harpoon'):list():append()<CR>")
vim.keymap.set("n", "<C-a>", ":lua require('harpoon'):list():select(1)<CR>")
vim.keymap.set("n", "<C-s>", ":lua require('harpoon'):list():select(2)<CR>")
vim.keymap.set("n", "<C-e>", ":lua require('harpoon'):list():select(3)<CR>")
vim.keymap.set("n", "<C-f>", ":lua require('harpoon'):list():select(4)<CR>")

-- Telescope
vim.keymap.set("n", "<leader>f", ":lua require('telescope.builtin').find_files({hidden=true})<CR>")
vim.keymap.set("n", "<leader>F", ":lua require('telescope.builtin').buffers()<CR>")
vim.keymap.set("n", "<leader>sg", ":lua require('telescope.builtin').live_grep()<CR>")
vim.keymap.set("n", "<leader>sc", ":lua require('telescope.builtin').commands()<CR>")
vim.keymap.set("n", "<leader>sk", ":lua require('telescope.builtin').keymaps()<CR>")

-- LSP
vim.keymap.set("n", "<leader>vi", ":LspInfo<CR>")
vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "<leader>vw", ":lua vim.diagnostic.workspace_symbol()<CR>")
vim.keymap.set("n", "<leader>vc", ":lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<leader>vr", ":lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "<leader>va", ":lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<leader>vh", ":lua vim.lsp.buf.help()<CR>")

-- Debugging
vim.keymap.set("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<F5>", ":lua require('dap').continue()<CR>")
vim.keymap.set("n", "<F10>", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<F11>", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<F12>", ":lua require('dap').step_out()<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")

-- Git
vim.keymap.set("n", "<leader>g", ":vertical Git<CR>")
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- Open glow
vim.keymap.set("n", "<leader>mp", ":term glow %<CR>")
vim.keymap.set("n", "<leader>mt", ":term glow ~/.dotfiles/personal/TODO.md<CR>")

-- Zen mode
vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = 90,
            options = {}
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
end)

vim.keymap.set("n", "<leader>zZ", function()
    require("zen-mode").setup {
        window = {
            width = 80,
            options = {}
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = false
    vim.wo.rnu = false
    vim.opt.colorcolumn = "0"
end)
