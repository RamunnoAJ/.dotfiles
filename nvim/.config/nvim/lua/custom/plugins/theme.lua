return {
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
      }
    })
    onedark.load()

    vim.cmd.colorscheme 'onedark'
  end,
}
