return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      theme = 'palenight',
      component_separators = '|',
      section_separators = '',
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          'mode',
          icon = nil,
        }
      },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'error', 'warn' },
          symbols = { error = ' ', warn = ' ' },
          update_in_insert = false,
          colored = false,
          always_visible = true
        },
        {
          'filetype',
          icon_only = false,
          colored = true,
          icon = { align = 'right' },
        },
      },
      lualine_z = {
        {
          'datetime',
          style = '%H:%M',
        }
      }

    }
  },
}
