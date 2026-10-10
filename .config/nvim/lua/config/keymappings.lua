
local function map(m, k, v)
	vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

-- set leader
map("","<Space>","<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Terminal Mode Custom
vim.keymap.set("t","<Esc>",[[<C-\><C-n>]],{ desc = 'Exit terminal mode' })
-- Buffers
map("n", "<S-l>",":bnext<CR>")
map("n", "<S-h>",":bprevious<CR>")
map("n","<leader>q",":BufferClose<CR>")
map("n","<leader>Q",":BufferClose!<CR>")
map("n","<leader>vs",':vsplit<CR>:bnext<CR>') -- split and open next buffer in split window
map("n","<leader>ts",':split<CR>:resize +15<CR>:wincmd j<CR>:terminal<CR>:startinsert<CR>')
map('n',"<leader>-",':resize -5<CR>')
map('n',"<leader>+",':resize +5<CR>')
-- fzf Lua fuzzy finder
local fzf_lua = require('fzf-lua')
vim.keymap.set('n', '<leader>ff', fzf_lua.files, { desc = 'fzf-lua find files' })
vim.keymap.set('n', '<leader>fg', fzf_lua.live_grep, { desc = 'fzf-lua live grep' })
vim.keymap.set('n', '<leader>fb', fzf_lua.buffers, { desc = 'fzf-lua buffers' })
vim.keymap.set('n', '<leader>fh', fzf_lua.help_tags, { desc = 'fzf-lua help tags' })

