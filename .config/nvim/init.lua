local vim = vim
local Plug = vim.fn['plug#']

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Indentation changes
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "auto"
vim.opt.wrap = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.call('plug#begin')

Plug('uZer/pywal16.nvim',{['as'] = 'pywal16'}) -- Color Scheme from Wallpaper
Plug('nvim-tree/nvim-tree.lua') -- File Tree
Plug('nvim-tree/nvim-web-devicons') -- Icons!
Plug('saghen/blink.cmp', {['tag'] = 'v1'})
Plug('rafamadriz/friendly-snippets')

vim.call('plug#end')

local pywal16 = require('pywal16');
pywal16.setup()

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

require('config.diagnostic')
require('lsp')

require('nvim-tree.api').tree.open()

require('blink.cmp').setup({
	keymap = { preset = 'default'},
	appearance = { nerd_font_variant = 'mono' },
	completion = { documentation = { auto_show = true } },
	sources = { default = { 'lsp','path','snippets','buffer'} },
	fuzzy = { implementation = "prefer_rust_with_warning" }
})
