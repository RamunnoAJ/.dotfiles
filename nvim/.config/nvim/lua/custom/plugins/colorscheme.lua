return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        local rose_pine = require("rose-pine")
        rose_pine.setup {
            variant = "main",
            dark_variant = "main",
            dim_inactive_background = false,
            disable_background = true,
            disable_float_background = true,
            extend_background_behind_borders = true,

            styles = {
                bold = true,
                italic = false,
                transparency = true
            },

            groups = {
                background = "base",
                background_nc = "_experimental_nc",
                panel = "surface",
                panel_nc = "base",
                border = "highlight_med",
                comment = "muted",
                link = "iris",
                punctuation = "subtle",

                error = "love",
                hint = "iris",
                info = "foam",
                warn = "gold",

                headings = {
                    h1 = "iris",
                    h2 = "foam",
                    h3 = "rose",
                    h4 = "gold",
                    h5 = "pine",
                    h6 = "foam",
                }
            },

            highlight_groups = {
                ColorColumn = { bg = "rose" },
                CursorLine = { bg = "foam", blend = 10 },
                StatusLine = { fg = "love", bg = "love", blend = 10 },
                StatusLineNC = { fg = "subtle", bg = "surface" },
                Search = { bg = "gold", inherit = false },
                GitSignsAdd = { bg = "NONE" },
                GitSignsChange = { bg = "NONE" },
                GitSignsDelete = { bg = "NONE" },
            }
        }
        vim.cmd.colorscheme("rose-pine")
        vim.cmd "highlight Search guibg=#E58AC8 guifg=#1D1E2C"
    end,
}
