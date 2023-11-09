-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x',   dependencies = { 'nvim-lua/plenary.nvim' } },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'lukas-reineke/lsp-format.nvim',
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  { 'ferrine/md-img-paste.vim',      ft = { "markdown" } },
  "moll/vim-bbye",
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost", },
}
