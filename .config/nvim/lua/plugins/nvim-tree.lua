local p16colors = require('pywal16.core').get_colors()

require('nvim-tree').setup({
  renderer = {
    icons = {
      show = {
	      file = true,
	      folder = true,
	      folder_arrow = true,
	      git = true
      },
    },
  },
})

vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { bg = p16colors.cursor, fg = p16colors.background })
vim.api.nvim_set_hl(0, 'NvimTreeRootFolder', { bg = 'None', fg = p16colors.color4 })
