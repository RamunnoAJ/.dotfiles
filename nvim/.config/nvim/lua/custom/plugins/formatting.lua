return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                rust = { "rust-analyzer" },
                markdown = { "prettier" },
                ["*"] = { "codespell" },
                ["_"] = { "trim_whitespace" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500
            }
        })
    end
}
