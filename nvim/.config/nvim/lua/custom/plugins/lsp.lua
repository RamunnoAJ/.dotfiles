return {

    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { "williamboman/mason.nvim",                     config = true },
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost", },
    },

    config = function()
        require("fidget").setup({})
    end
}
