return {
  --{
  -- "bluz71/vim-nightfly-guicolors",
  --priority = 1000, -- make sure to load this before all the other start plugins
  -- config = function()
  -- load the colorscheme here
  --   vim.cmd([[colorscheme nightfly]])
  -- end,
  --},

  'navarasu/onedark.nvim',
  priority = 1000,

  config = function()
    local onedark = require("onedark")
    onedark.setup({
      style = 'cool',
      term_colors = true,
      transparent = false,
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
      },
      lualine = {
        transparent = true
      }
    })
    onedark.load()

    vim.cmd.colorscheme 'onedark'
  end,
}
