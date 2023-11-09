return {
  'stevearc/conform.nvim',
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "eslint_d" },
        typescript = { "prettierd", "eslint_d" },
        javascriptreact = { "prettierd", "eslint_d" },
        typescriptreact = { "prettierd", "eslint_d" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        markdown = { "prettier" },
        c = { "clang_format" },
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
