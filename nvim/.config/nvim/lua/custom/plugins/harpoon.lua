return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    branch = 'harpoon2',
    config = function()
        local harpoon = require("harpoon")
        ---@diagnostic disable-next-line: missing-parameter
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            }
        })

        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-x>", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })
            end
        })

        vim.keymap.set("n", "<M-e>",
            function()
                harpoon.ui:toggle_quick_menu(harpoon:list(),
                    { border = "rounded", ui_width_ratio = 0.3, ui_fallback_width = 0.25 })
            end)
    end,
}
