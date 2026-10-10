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
Plug('ibhagwan/fzf-lua') -- Fuzzy Finder
Plug('nvim-tree/nvim-web-devicons') -- Icons!
Plug('saghen/blink.cmp', {['tag'] = 'v1'}) -- Autocomplete
Plug('rafamadriz/friendly-snippets') -- Snippet support for blink
Plug('folke/which-key.nvim') -- Hints for shortcuts
Plug('romgrk/barbar.nvim') -- Tab Bar up top
Plug('nvim-treesitter/nvim-treesitter') -- better syntax highlight? Does it even work? TODO:
Plug('uga-rosa/ccc.nvim') -- Preview Colors in text
Plug('nvim-lualine/lualine.nvim') -- That input bar at the bottom
Plug('meanderingprogrammer/render-markdown.nvim') -- Todo:/ I am not really happy with this one.
Plug('windwp/nvim-autopairs') -- Automatically close brackets
Plug('numToStr/Comment.nvim') -- Easier comments with g-c-c or g-c-b hotkeys
-- Language Server Support
Plug('mason-org/mason.nvim') -- LSP and DAP manager for nvim
Plug('mason-org/mason-lspconfig.nvim') -- Adds auto download and installing for mason
-- Debugging
Plug('mfussenegger/nvim-dap') -- Debugger adapter framework
Plug('nvim-neotest/nvim-nio') -- Async Io Library requried  by dap ui
Plug('rcarriga/nvim-dap-ui') -- Nicer readable UI for debugging
-- Git Utils and Diff view
Plug('sindrets/diffview.nvim')
vim.call('plug#end')

vim.opt.termguicolors = true

local pywal16 = require('pywal16');
pywal16.setup()

require('lualine').setup({})
require('render-markdown').setup({})
require('plugins.nvim-tree')
require('plugins.mason')
require('plugins.barbar')
require('plugins.lualine')
require('plugins.treesitter')
require('plugins.blink')
require('plugins.ccc')
require('plugins.autopairs')
require('Comment').setup()
require('plugins.fzf-lua')
require('config.keymappings')
require('config.diagnostic')

require('lsp')
require('nvim-tree.api').tree.open()

require('plugins.nvim-dap')

vim.defer_fn(function()
	vim.cmd("wincmd l")
end,100)
