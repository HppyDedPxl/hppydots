-- BarBar setup
local p16colors = require('pywal16.core').get_colors()

vim.g.barbar_auto_setup = false
require("barbar").setup({
	animation = true,
	tabpages = true,
	focus_on_close = 'left',
	hide = { extensions = false, inactive = false },
	icons = {
		buffer_index = false,
		buffer_number = false,
		button = '',
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' }
		},
		gitsigns = {
			added = { enabled = true, icon = ' ' },
			changed = { enabled = true, icon = ' ' },
			deleted = { enabled = true, icon = ' ' }
		},
		-- Configure the icons on the bufferline when modified or pinned.
		separator = { left = '', right = '' },
		-- If true, add an additional separator at the end of the buffer list
		separator_at_end = false,

		-- Supports all the base icon options.
		modified = { button = '●' },
		pinned = { button = '', filename = true },
		filetype = {
			custom_colors = true
		},
		-- Configure the icons on the bufferline based on the visibility of a buffer.
    -- Supports all the base icon options, plus `modified` and `pinned`.
		alternate = { filetype = { enabled = false } },
		current = { buffer_index = true, custom_colors = true },
		inactive = { button = '×', separator = { left = '', right = '' },},
		visible = { modified = { buffer_number = false } ,separator = { left = '', right = '' },}
	},

	sidebar_filetypes = { -- Set the filetypes which barbar will offset itself for
		-- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
		NvimTree = true,
		-- Or, specify the text used for the offset:
		undotree = {
			text = 'undotree',
			align = 'left' -- *optionally* specify an alignment (either 'left', 'center', or 'right')
		},
		-- Or, specify the event which the sidebar executes when leaving:
		['neo-tree'] = { event = 'BufWipeout' },
		-- Or, specify all three
		Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' }
	},
	maximum_length = 25 -- Sets the maximum buffer name length.

	-- Pywal 16 Theme Support
})
local function SetBufferColors(type, bg, fg)
	vim.api.nvim_set_hl(0, 'Buffer' .. type, { bg = bg, fg = fg, bold = true })
	vim.api.nvim_set_hl(0, 'Buffer' .. type .. 'Mod', { bg = bg, fg = fg })
	vim.api.nvim_set_hl(0, 'Buffer' .. type .. 'ERROR', { bg = bg, fg = fg })
	vim.api.nvim_set_hl(0, 'Buffer' .. type .. 'Index', { bg = bg, fg = fg })
	vim.api.nvim_set_hl(0, 'Buffer' .. type .. 'Sign', { bg = fg, fg = bg })
end

local function SetSeperatorColors(type, bg, fg)
	vim.api.nvim_set_hl(0, 'Buffer' .. type .. 'Sign', {bg = bg, fg = fg })
end
local hi_color = p16colors.color4
local seperator_color = p16colors.color8
SetBufferColors('Current', hi_color, p16colors.background)
SetSeperatorColors('Current',p16colors.background,hi_color)
SetBufferColors('Visible', 'None', p16colors.foreground)
SetSeperatorColors('Visible','None',seperator_color) 
SetBufferColors('Inactive', 'None', p16colors.foreground)
SetSeperatorColors('Inactive','None',seperator_color) 
