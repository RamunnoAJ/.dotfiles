vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.cursorcolumn = false
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.laststatus = 0
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.signcolumn = "yes:9"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.virtualedit = "block"
vim.opt.winbar = '%=%m %f'
vim.opt.winblend = 0
vim.opt.winborder = "rounded"
vim.opt.wrap = false

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 0
vim.g.netrw_list_hide = ".*\\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\\.\\.\\=/\\=$"
vim.g.netrw_browse_split = 0

vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp", version = "1.*" },
})

require "mason".setup()
require "telescope".setup()
require "fidget".setup({})
require "nvim-treesitter.configs".setup({
	modules = {},
	sync_install = false,
	ignore_install = {},
	auto_install = true,
	indent = { enable = true },
	ensure_installed = { "typescript", "javascript" },
	highlight = { enable = true }
})
require "conform".setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
	},
})
require "gitsigns".setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "-" },
		changedelete = { text = "~" }
	},
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,
})
require "blink.cmp".setup({
	signature = { enabled = true },
	fuzzy = { implementation = "lua" },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "label", "label_description", gap = 1 } },
			}
		}
	}
})

local map = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local RamunnoGroup = augroup('Ramunno', {})
local autocmd = vim.api.nvim_create_autocmd

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

autocmd({ "FileType" }, {
	pattern = "netrw",
	group = RamunnoGroup,
	desc = "Netrw specific mappings",

	callback = function()
		map("n", "<C-c>", ":Rex<CR>", { remap = true, buffer = true })
		map("n", "h", "-", { remap = true, buffer = true })
		map("n", "l", "<CR>", { remap = true, buffer = true })
	end
})

vim.g.mapleader = " "
map('n', '<leader>o', ':source ~/.config/nvim/init.lua<CR>')

-- Move text with <up/down>
map('n', '<M-j>', '<Esc>:m .+1<CR>==')
map('n', '<M-k>', '<Esc>:m .-2<CR>==')
map('v', '<M-j>', ":m '>+1<CR>gv=gv")
map('v', '<M-k>', ":m '<-2<CR>gv=gv")

map('i', '<C-c>', '<Esc>')
map('n', 'J', 'mzJ`z', { silent = true }) -- Don't move the cursor when doing J

-- Better paste
map('v', 'p', '"_dp')
map('v', 'P', '"_dP')
map('n', ',p', '"0p')
map('n', ',P', '"0P')

-- Actions not yanking
map('n', 'd', '"_d')
map('v', 'd', '"_d')
map('n', 'D', '"_D')
map('v', 'D', '"_D')
map('n', 'x', '"_x')
map('v', 'x', '"_x')
map('n', 'c', '"_c')
map('v', 'c', '"_c')
map('n', 'C', '"_C')
map('v', 'C', '"_C')

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Better navigation with <C-d> and <C-u>
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Surround selection with brackets
map('v', '(', '<esc>`>a)<esc>`<i(<esc>gv')
map('v', '[', '<esc>`>a]<esc>`<i[<esc>gv')
map('v', '{', '<esc>`>a}<esc>`<i{<esc>gv')
map('v', "'", "<esc>`>a'<esc>`<i'<esc>gv")
map('v', '"', '<esc>`>a"<esc>`<i"<esc>gv')
map('v', '`', '<esc>`>a`<esc>`<i`<esc>gv')

-- Keep selection after yanking
map('x', 'y', 'ygv')

-- Keep selection after Indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

map('n', '<leader>c', ':bw!<CR>', { silent = true })                      -- Close buffer
map('n', '<leader>C', ':silent w!|%bd|e#|bd#|\'"<CR>', { silent = true }) -- Close all buffers except current
map('n', '<Esc>', '<cmd>noh<CR>', { silent = true })                      -- Remove highlight search
map('n', '<leader>e', '<cmd>:Ex<CR>')                                     -- Explore netrw

vim.cmd("set iskeyword+=-")

map('n', 'gd', vim.lsp.buf.definition)
map('n', 'gD', vim.lsp.buf.declaration)
map('n', 'gr', require('telescope.builtin').lsp_references)
map('n', 'gi', vim.lsp.buf.implementation)
map('n', 'gt', vim.lsp.buf.type_definition)
map('n', 'K', vim.lsp.buf.hover)
map('n', '<C-k>', vim.lsp.buf.signature_help)
map('n', '<leader>r', vim.lsp.buf.rename)
map('n', '<leader>s', vim.lsp.buf.code_action)
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '[d', function()
	vim.diagnostic.jump({ count = -1 })
	vim.diagnostic.open_float(nil, { focus = false })
end)
map('n', ']d', function()
	vim.diagnostic.jump({ count = 1 })
	vim.diagnostic.open_float(nil, { focus = false })
end)

map('n', '<leader><leader>', function()
	vim.diagnostic.open_float(nil, { focus = true })
end)

-- Telescope
map('n', '<leader>f', ":lua require('telescope.builtin').find_files({hidden=true})<CR>")
map('n', '<C-p>', function()
	local ok = pcall(require("telescope.builtin").git_files)
	if not ok then
		require("telescope.builtin").find_files()
	end
end)
map('n', '<leader>g', ":lua require('telescope.builtin').live_grep()<CR>")
map('n', '<leader>d', ":lua require('telescope.builtin').diagnostics()<CR>")

-- Toggle signcolumn
map('n', '<leader>z', function()
	local signcolumn = vim.wo.signcolumn

	if signcolumn == 'yes' then
		vim.wo.signcolumn = 'yes:9'
	else
		vim.wo.signcolumn = 'yes'
	end
end)

-- Show signature help on insert mode to see function's parameters
map('i', '<C-k>', function()
	vim.lsp.buf.signature_help()
end, { desc = 'Signature Help' })

vim.lsp.enable({ "lua_ls", "ts_ls", "gopls" })

-- colors
require "rose-pine".setup({
	styles = {
		bold = true,
		italic = false,
		transparency = true,
	}
})
vim.cmd("colorscheme rose-pine")
vim.cmd(":hi statusline guibg=NONE")
vim.o.background = "dark"
