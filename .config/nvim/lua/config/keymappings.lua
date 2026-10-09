
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
