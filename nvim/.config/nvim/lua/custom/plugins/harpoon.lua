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
      "<space>hq",
      function()
        require("harpoon.mark").clear_all()
      end,
      desc = { "Clear all marks" },
      opts,
    },
    {
      "<M-1>",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = { "Navigate to file 1" },
      opts,
    },
    {
      "<M-2>",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = { "Navigate to file 2" },
      opts,
    },
    {
      "<M-3>",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = { "Navigate to file 3" },
      opts,
    },
    {
      "<M-4>",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = { "Navigate to file 4" },
      opts,
    },
    {
      "<M-5>",
      function()
        require("harpoon.ui").nav_file(5)
      end,
      desc = { "Navigate to file 5" },
      opts,
    },
    {
      "<M-6>",
      function()
        require("harpoon.ui").nav_file(6)
      end,
      desc = { "Navigate to file 6" },
      opts,
    },
    {
      "<M-7>",
      function()
        require("harpoon.ui").nav_file(7)
      end,
      desc = { "Navigate to file 7" },
      opts,
    },
    {
      "<M-8>",
      function()
        require("harpoon.ui").nav_file(8)
      end,
      desc = { "Navigate to file 8" },
      opts,
    },
    {
      "<M-9>",
      function()
        require("harpoon.ui").nav_file(9)
      end,
      desc = { "Navigate to file 9" },
      opts,
    },
    {
      "<M-0>",
      function()
        require("harpoon.ui").nav_file(9)
      end,
      desc = { "Navigate to file 10" },
      opts,
    },
    {
      "<space>hd",
      function()
        local index = require("harpoon.mark").get_index_of(vim.fn.bufname())
        require("harpoon.mark").delete(index)
      end,
      opts,
    },
  }
}
