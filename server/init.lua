local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    { 
        "rose-pine/neovim", 
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                styles = {
                    bold = true,
                    italic = false,
                    transparency = true,
                }
            })
            vim.cmd("colorscheme rose-pine")
            vim.cmd(":hi statusline guibg=NONE")
            vim.o.background = "dark"
        end
    },
    { 
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        config = function() 
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = { "bash", "lua", "vim", "vimdoc", "javascript", "typescript", "json", "yaml", "go" },
            })
        end 
    },
    { "mason-org/mason.nvim", config = true },
    { "nvim-lua/plenary.nvim" },
    { 
        "nvim-telescope/telescope.nvim", 
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true 
    },
    { "j-hui/fidget.nvim", config = true },
    { 
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    javascript = { "prettierd" },
                    typescript = { "prettierd" },
                    javascriptreact = { "prettierd" },
                    typescriptreact = { "prettierd" },
                    lua = { "stylua" },
                    go = { "gofmt" },
                },
            })
        end
    },
    { 
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "-" },
                    changedelete = { text = "~" }
                },
            })
        end
    },
    {
        "Saghen/blink.cmp",
        version = "v0.*",
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            signature = { enabled = true },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
    }
})

-- Options
vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.winbar = '%=%m %f'

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 0
vim.g.netrw_browse_split = 0

-- Keymaps
local map = vim.keymap.set

map('n', '<leader>o', ':source $MYVIMRC<CR>')
map('n', '<leader>e', ':Ex<CR>')

-- Move text
map('n', '<M-j>', '<Esc>:m .+1<CR>==')
map('n', '<M-k>', '<Esc>:m .-2<CR>==')
map('v', '<M-j>', ":m '>+1<CR>gv=gv")
map('v', '<M-k>', ":m '<-2<CR>gv=gv")

-- Navigation
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Clipboard
map('x', '<leader>p', '"_dP')
map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')
map('n', '<leader>Y', '"+Y')

-- Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>f', builtin.find_files, {})
map('n', '<C-p>', builtin.git_files, {})
map('n', '<leader>g', builtin.live_grep, {})
map('n', '<leader>d', builtin.diagnostics, {})

-- Formatting
map('n', '<leader>lf', function() require("conform").format({ lsp_fallback = true }) end)

-- LSP (simplified attach)
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }
        map('n', 'gd', vim.lsp.buf.definition, opts)
        map('n', 'K', vim.lsp.buf.hover, opts)
        map('n', '<leader>r', vim.lsp.buf.rename, opts)
        map('n', '<leader>s', vim.lsp.buf.code_action, opts)
    end,
})

-- Enable some default LSPs if available via mason or system
-- Note: On a lightweight server, you might not have these installed.
-- Mason will try to install them if configured, but we keep it simple here.
