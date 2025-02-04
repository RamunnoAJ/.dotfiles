local augroup = vim.api.nvim_create_augroup
local RamunnoGroup = augroup('Ramunno', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    return require("ramunnoaj." .. name)
end

local options = {
    autoindent = true,
    backup = false,                                  -- creates a backup file
    breakindent = true,
    clipboard = "unnamedplus",                       -- allows neovim to access the system clipboard
    colorcolumn = "100",
    completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
    cursorline = true,                               -- highlight the current line
    expandtab = true,                                -- convert tabs to spaces
    fileencoding = "utf-8",                          -- the encoding written to a file
    fillchars = "eob: ",
    hlsearch = true,                                 -- highlight all matches on previous search pattern
    ignorecase = true,                               -- ignore case in search patterns
    inccommand = "split",                            -- display effects while substitute
    incsearch = true,
    jumpoptions = "stack",
    laststatus = 0,
    listchars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣',
    guicursor = "",
    modeline = false,
    mouse = "a",    -- allow the mouse to be used in neovim
    number = true,  -- set numbered lines
    pumheight = 10, -- pop up menu height
    rnu = true,     -- set relative number
    scrolloff = 8,  -- is one of my fav
    softtabstop = 4,
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    showcmd = true,
    showmatch = true,
    showmode = true, -- show current mode like: -- INSERT --
    showtabline = 0, -- determine if the tab pages line is displayed
    sidescrolloff = 8,
    signcolumn = "yes:9",
    smartcase = true,     -- smart case
    smartindent = true,   -- make indenting smarter again
    splitbelow = true,    -- force all horizontal splits to go below current window
    splitright = true,    -- force all vertical splits to go to the right of current window
    swapfile = false,     -- creates a swapfile
    tabstop = 4,
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeout = true,       -- time to wait for a mapped sequence to complete
    timeoutlen = 300,     -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,      -- enable persistent undo
    updatetime = 50,      -- faster completion (4000ms default)
    virtualedit = "block",
    wildmenu = true,      -- Display all matching files when we tab complete
    wrap = false,         -- display lines as one long line
    winbar = '%=%m %f',   -- sets de status bar of the window to the current file
    winblend = 0,
    writebackup = false,  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.isfname:append("@-@")
vim.opt.shortmess:append "c"
vim.opt.path:append "**" -- Provides tab-completion for all file-related tasks

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" } -- Disable auto comment
    end,
    desc = "Remove comment characters when joining lines",
})

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "set showmode"
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

-- Load and save folders in view when closing and opening
vim.api.nvim_exec2([[
            augroup BufferView
              autocmd!
              autocmd BufWinLeave *.*  mkview
              autocmd BufWinEnter *.* silent! loadview
            augroup END
          ]], { output = false })

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = RamunnoGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd({ "LspAttach" }, {
    group = RamunnoGroup,
    callback = function(ev)
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
        end

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    end
})

autocmd({ "FileType" }, {
    group = RamunnoGroup,
    pattern = { "gitcommit", "gitrebase" },
    command = "startinsert | 1"
})

autocmd({ "FileType" }, {
    group = RamunnoGroup,
    pattern = { "gitcommit", "gitrebase", "fugitive", "undotree", "diff" }, -- Disable sign column for these file types
    callback = function()
        vim.o.signcolumn = "no"
    end
})

autocmd({ "BufLeave", "ExitPre" }, {
    pattern = "*",
    callback = function()
        local filename = vim.fn.expand("%:p:.")
        local harpoon_marks = require("harpoon"):list().items
        for _, mark in ipairs(harpoon_marks) do
            if mark.value == filename then
                mark.context.row = vim.fn.line(".")
                mark.context.col = vim.fn.col(".")
                return
            end
        end
    end
})

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 0
vim.g.netrw_list_hide = ".*\\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\\.\\.\\=/\\=$"
vim.g.netrw_browse_split = 0
vim.g.netrw_browsex_viewer = "open -a chrome"

vim.opt_local.colorcolumn = "0"
vim.opt.diffopt:append("linematch:50")

autocmd({ "FileType" }, {
    pattern = "netrw",
    group = RamunnoGroup,
    desc = "Netrw specific mappings",

    callback = function()
        vim.keymap.set("n", "<C-c>", ":Rex<CR>", { remap = true, buffer = true })
        vim.keymap.set("n", "h", "-", { remap = true, buffer = true })
        vim.keymap.set("n", "l", "<CR>", { remap = true, buffer = true })
        vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { remap = true, buffer = true })
    end
})

vim.api.nvim_create_user_command("FileType", function()
    local filetype = vim.bo.filetype

    print("Filetype: " .. filetype)
end, {})

-- rebind W and Q to w and q
vim.cmd "command! Wq wq"
vim.cmd "command! W w"
vim.cmd "command! Q q"
