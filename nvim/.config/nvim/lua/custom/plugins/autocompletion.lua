return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        "Exafunction/codeium.vim",
    },

    config = function()
        local cmp = require("cmp")
        local types = require("cmp.types")

        -- Function to sort LSP snippets, so that they appear at the end of LSP suggestions
        local function deprioritize_snippet(entry1, entry2)
            if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
                return false
            end
            if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
                return true
            end
        end

        -- Take care of source ordering and group_index
        cmp.setup({
            sorting = {
                priority_weight = 2,
                comparators = {
                    deprioritize_snippet,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                }
            }
        })
    end
}
