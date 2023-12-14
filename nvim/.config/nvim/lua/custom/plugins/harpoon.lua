return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  branch = 'harpoon2',
  config = function()
    local harpoon = require("harpoon")
    ---@diagnostic disable-next-line: missing-parameter
    harpoon:setup()

    vim.keymap.set("n", "<M-0>",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list(),
          { border = "rounded", ui_width_ratio = 0.3, ui_fallback_width = 0.25 })
      end)
  end,
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
    key = function()
      return vim.loop.cwd()
    end,
  }
}
