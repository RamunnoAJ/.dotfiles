local options = {
  backup = false,                                  -- creates a backup file
  breakindent = true,
  clipboard = "unnamedplus",                       -- allows neovim to access the system clipboard
  completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
  cursorline = true,                               -- highlight the current line
  expandtab = true,                                -- convert tabs to spaces
  fileencoding = "utf-8",                          -- the encoding written to a file
  hlsearch = false,                                -- highlight all matches on previous search pattern
  ignorecase = true,                               -- ignore case in search patterns
  inccommand = "split",                            -- display effects while substitute
  laststatus = 3,
  listchars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣',
  guifont = { "JetBrainsMono Nerd Font", ":h12" }, -- the font used in graphical neovim applications
  guicursor = "",
  modeline = false,
  mouse = "a",     -- allow the mouse to be used in neovim
  number = true,   -- set numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  pumheight = 10,  -- pop up menu height
  scrolloff = 8,   -- is one of my fav
  softtabstop = 2,
  shiftwidth = 2,  -- the number of spaces inserted for each indentation
  showcmd = true,
  showmatch = true,
  showmode = false,     -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,      -- determine if the tab pages line is displayed
  sidescrolloff = 8,
  signcolumn = "yes",   -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,     -- smart case
  smartindent = true,   -- make indenting smarter again
  splitbelow = true,    -- force all horizontal splits to go below current window
  splitright = true,    -- force all vertical splits to go to the right of current window
  swapfile = false,     -- creates a swapfile
  tabstop = 2,          -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeout = true,       -- time to wait for a mapped sequence to complete
  timeoutlen = 300,     -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,      -- enable persistent undo
  updatetime = 250,     -- faster completion (4000ms default)
  wildmenu = true,      -- Display all matching files when we tab complete
  wrap = true,          -- display lines as one long line
  winbar = '%=%m %f',
  writebackup = false,  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append "c"
vim.opt.path:append "**" -- Provides tab-completion for all file-related tasks

vim.wo.number = true
vim.wo.signcolumn = 'yes'
vim.wo.relativenumber = true

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" } -- Disable auto comment
  end,
  desc = "Remove comment characters when joining lines",
})


for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.netrw_list_hide = "^./$"
vim.g.netrw_hide = 1

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
