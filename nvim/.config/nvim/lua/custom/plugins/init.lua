-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
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
  "moll/vim-bbye",
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost", },
  'Exafunction/codeium.vim',
  'mbbill/undotree',
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  'christoomey/vim-tmux-navigator',
  'xiyaowong/transparent.nvim'
}
