return {
  'phaazon/hop.nvim',
  branch = 'v2',
  config = function()
    local status_ok, hopnvim = pcall(require, 'hop')
    if not status_ok then
      return
    end

    hopnvim.setup { keys = 'etovxqpdygfblzhckisuran' }
    vim.api.nvim_set_keymap('', 'f',
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
      , {})
    vim.api.nvim_set_keymap('', 'F',
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
      , {})
    vim.api.nvim_set_keymap('', 't',
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
      , {})
    vim.api.nvim_set_keymap('', 'T',
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
      , {})
    vim.api.nvim_set_keymap("n", "S", "<cmd>HopChar2<CR>", { noremap = false })
  end,
  event = "BufReadPost",
}