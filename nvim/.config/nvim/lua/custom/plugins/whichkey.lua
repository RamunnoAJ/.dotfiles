return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
      return
    end

    local _, gitsigns = pcall(require, 'gitsigns')
    if not _ then print('gitsigns is not installed') end

    local setup = {
      plugins = {
        marks = true,       -- shows a list of your marks on ' and `
        registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false,      -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = true,       -- default bindings on <c-w>
          nav = true,           -- misc bindings to work with windows
          z = true,             -- bindings for folds, spelling and others prefixed with z
          g = true,             -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      -- operators = { gc = "Comments" },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
      },
      window = {
        border = "rounded",       -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 },                                             -- min and max height of the columns
        width = { min = 20, max = 50 },                                             -- min and max width of the columns
        spacing = 3,                                                                -- spacing between columns
        align = "left",                                                             -- align columns left, center or right
      },
      ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = true,                                                             -- show help message on the command line when the popup is visible
      triggers = "auto",                                                            -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    }

    local opts = {
      mode = "n",     -- NORMAL mode
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }

    local mappings = {
      ["b"] = {
        function()
          require('telescope.builtin').buffers(require('telescope.themes').get_dropdown { previewer = false })
        end,
        "Buffers",
      },
      ["w"] = { "<cmd>w!<CR>", "Save" },
      ["q"] = { "<cmd>q!<CR>", "Quit" },
      ["Q"] = { "<cmd>qall<CR>", "Quit All" },
      ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
      ["p"] = { '<cmd>Telescope neoclip<CR>', 'Clipboard Viewer' },
      ["e"] = { "<cmd>e .<CR>", "Open File Explorer" },
      ["f"] = {
        function()
          require('telescope.builtin').find_files(require('telescope.themes').get_dropdown { previewer = false })
        end,
        "Find files",
      },
      d = {
        name = 'Debugger',
        b = { require('dap').toggle_breakpoint, 'Toggle Breakpoint' },
        B = { function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
          'Conditional Breakpoint' },
        p = { function()
          require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
        end,
          'Print Point'
        },
        r = { require('dap').repl.open, 'Open Repl' },
        t = { require('dap').terminate, 'Terminate Debug' },
      },
      g = {
        name = "Git",
        j = { gitsigns.next_hunk, "Next Hunk" },
        k = { gitsigns.prev_hunk, "Prev Hunk" },
        l = { gitsigns.blame_line, "Blame" },
        p = { gitsigns.preview_hunk, "Preview Hunk" },
        r = { gitsigns.reset_hunk, "Reset Hunk" },
        R = { gitsigns.reset_buffer, "Reset Buffer" },
        s = { gitsigns.stage_hunk, "Stage Hunk" },
        u = { gitsigns.undo_stage_hunk, "Undo Stage Hunk", },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { require('telescope.builtin').git_branches, "Checkout branch" },
        c = { require('telescope.builtin').git_commits, "Checkout Commits" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff", },
      },
      l = {
        name = "LSP",
        a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
        c = { '<cmd>NodeAction<CR>', 'Node Action' },
        d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics", },
        w = { require('telescope.builtin').diagnostics, "Workspace Diagnostics", },
        f = {
          function()
            vim.lsp.buf.format { async = true }
          end,
          "Format"
        },
        i = { "<cmd>LspInfo<cr>", "Info" },
        m = { "<cmd>Mason<cr>", "Mason" },
        --[[ j = { vim.diagnostic.goto_next, "Next Diagnostic", }, ]]
        --[[ k = { vim.diagnostic.goto_prev, "Prev Diagnostic", }, ]]
        s = { require('telescope.builtin').lsp_document_symbols, "Document Symbols" },
        S = { require('telescope.builtin').lsp_dynamic_workspace_symbols, "Document Symbols" },
      },
      s = {
        name = "Search",
        c = { require('telescope.builtin').commands, "Commands" },
        s = { require('telescope.builtin').grep_string, "Grep String" },
        g = { require('telescope.builtin').live_grep, "Live Grep" },
        h = { require('telescope.builtin').help_tags, "Find Help" },
        m = { require('telescope.builtin').man_pages, "Man Pages" },
        r = { require('telescope.builtin').oldfiles, "Open Recent File" },
        R = { require('telescope.builtin').registers, "Registers" },
        k = { require('telescope.builtin').keymaps, "Keymaps" },
      },
    }

    local vopts = {
      mode = "v",     -- VISUAL mode
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }
    local vmappings = {
      ["/"] = { "<ESC><CMD>lua require(\"Comment.api\").toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
    }

    local second_opts = {
      mode = "n",
      prefix = ",",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    }

    local second_mappings = {
      ["s"] = { "<cmd>lua require('substitute').operator()<cr>", "Substitute" },
    }

    which_key.setup(setup)
    which_key.register(mappings, opts)
    which_key.register(vmappings, vopts)
    which_key.register(second_mappings, second_opts)
  end
}
