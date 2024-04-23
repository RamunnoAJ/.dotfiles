return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'nvim-neotest/nvim-nio'

        -- Add debuggers here
    },

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("mason-nvim-dap").setup {
            automatic_setup = true,
            handlers = {},
            ensure_installed = {
                -- Add language servers here
            }
        }

        dapui.setup {
            icons = {
                expanded = "▾",
                collapsed = "▸",
                current_frame = "*",
            },
            controls = {
                icons = {
                    pause = "⏸",
                    play = "▶",
                    step_into = "⏎",
                    step_over = "⏭",
                    step_out = "⏮",
                    step_back = "b",
                    run_last = "↻",
                    disconnect = "✖",
                }
            }
        }

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end
}
