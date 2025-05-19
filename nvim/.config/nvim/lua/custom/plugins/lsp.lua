return {
    'neovim/nvim-lspconfig',
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        vim.diagnostic.config {
            update_in_insert = false,
            float = {
                focusable = true,
                style = 'minimal',
                border = 'rounded',
                source = 'always',
                header = '',
                prefix = '',
            },
            virtual_text = true,
            signs = true, -- This disables sign column indicators
            underline = true
        }

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = "single" }
        )

        lspconfig.gopls.setup {
            capabilities = capabilities,
        }
        lspconfig.clangd.setup {
            capabilities = capabilities,
            cmd = { "clangd", "--compile-commands-dir=build" },
            root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
        }
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    },
                }
            }
        }
        lspconfig.ts_ls.setup {
            capabilities = capabilities,
        }
    end,
}
