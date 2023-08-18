return {
  'RRethy/vim-illuminate',
  config = function()
    local _, illuminate = pcall(require, 'illuminate')
    if not _ then return end

    illuminate.configure({
      filetypes_denylist = {
        'dirvish',
        'fugitive',
        'NvimTree',
        'alpha',
        'help',
      },
    })
  end,
  event = "BufReadPost",
}

