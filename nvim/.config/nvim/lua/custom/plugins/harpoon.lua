local opts = { noremap = true, silent = true }

return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    global_settings = {
      tabline = true,
      tabline_prefix = "  ",
      tabline_suffix = "  ",
    },
    menu = {
      width = vim.api.nvim_win_get_width(0) - 10,
    }
  },
  config = function()
    vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
    vim.cmd("highlight! HarpoonActive guibg=NONE guifg=black")
    vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
    vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
    vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
  end,
  keys = {
    {
      "<M-0>",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      opts,
    },
    {
      "<M-S>",
      function()
        require("harpoon.tmux").sendCommand(1, "npm run start")
      end,
      opts,
    },
    {
      "<M-N>",
      function()
        require("harpoon.tmux").gotoTerminal(1)
      end,
    }
  }
}
